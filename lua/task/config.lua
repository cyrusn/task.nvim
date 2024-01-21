local M = {}

-- Search All tasks in following directory
M.directory = "~/Documents/Note"

-- Search all tasks with following pattern
-- e.g. - [ ] this is task content [scheduled::2024-01-21]
M.task_pattern = "-\\s\\[\\s\\].*\\[scheduled::\\s?\\d{4}-\\d{2}-\\d{2}\\].*"

-- parse and filter that match the above pattern
-- return table with key of path, line_number, task
function M.parse_lines(lines)
	local results = {}

	for _, line in pairs(lines) do
		local loc = string.find(line, ":")

		local path = string.sub(line, 0, loc - 1)
		local remainder = string.sub(line, loc + 1, -1)

		loc = string.find(remainder, ":")
		local line_number = string.sub(remainder, 0, loc - 1)
		local task = string.sub(remainder, loc + 1, -1)

		-- trim task with whitespace
		task = task:gsub("^%s*(.-)%s*$", "%1")

		local i, j = string.find(task, "%d%d%d%d%-%d%d%-%d%d")
		if i == nil then
			return
		end
		local date_string = string.sub(task, i, j)

		local year = string.sub(date_string, 0, 4)
		local month = string.sub(date_string, 6, 7)
		local day = string.sub(date_string, 9, 10)

		local date = os.time({
			year = tonumber(year) or 0,
			month = tonumber(month) or 0,
			day = tonumber(day) or 0,
		})

		local now = os.time()

		if os.difftime(date, now) < 0 then
			table.insert(results, {
				task = task,
				path = path,
				line_number = tonumber(line_number),
			})
		end
	end
	return results
end

return M
