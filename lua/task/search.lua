local config = require("task.config")
local util = require("task.util")

local M = {}

function M.search(process, opts)
	local Job = require("plenary.job")

	local command = "rg"
	local task_pattern = config.task_pattern
	local directory = config.directory
	local path = vim.fs.normalize(tostring(directory))

	vim.schedule(function()
		Job:new({
			command = command,
			args = {
				"-e",
				task_pattern,
				path,
				"--no-heading",
				"--line-number",
				"-g",
				"*.md",
			},
			cwd = "/opt/homebrew/bin",
			on_exit = vim.schedule_wrap(function(j, code)
				if code == 2 then
					local error = table.concat(j:stderr_result(), "\n")
					util.error(command .. " failed with code " .. code .. "\n" .. error)
				end

				if code == 1 then
					util.warn("no task found")
				end

				local lines = j:result()
				process(lines, opts)
			end),
		}):start()
	end)
end

return M
