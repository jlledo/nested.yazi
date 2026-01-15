local root = ya.sync(function()
	return cx.active.current.cwd
end)

local function entry(_, job)
	local cwd = root()
	local cmd = Command("fd"):arg({ "--type", "f", "--hidden" }):cwd(tostring(cwd))
	local output, err = cmd:output()

	if not output then
		ya.err("Failed to run fd: " .. (err or "unknown error"))
		ya.notify({
			title = "Nested files",
			content = "`fd` failed, error: " .. err,
			timeout = 5,
			level = "error",
		})
		return
	end

	local id = ya.id("ft")
	local virtual_dir = cwd:into_search("All Files")

	ya.emit("cd", { Url(virtual_dir) })
	ya.emit("update_files", {
		op = fs.op("part", { id = id, url = Url(virtual_dir), files = {} }),
	})

	local files = {}
	for path in output.stdout:gmatch("[^\r\n]+") do
		local url = virtual_dir:join(path)
		local cha = fs.cha(url, true)
		if cha then
			files[#files + 1] = File({ url = url, cha = cha })
		end
	end

	ya.emit("update_files", {
		op = fs.op("part", { id = id, url = Url(virtual_dir), files = files }),
	})

	ya.emit("update_files", {
		op = fs.op("done", { id = id, url = virtual_dir, cha = Cha({ kind = 16 }) }),
	})
end

return { entry = entry }
