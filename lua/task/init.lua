local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local config = require("task.config")
local search = require("task.search")

local M = {}

function M.setup() end

function M.search()
	search.search(M.process)
end

function M.process(lines, opts)
	local results = config.parse_lines(lines)

	pickers
		.new(opts, {
			prompt_title = "Task scheduled on or before today",
			finder = finders.new_table({
				results = results,
				entry_maker = function(entry)
					return {
						value = entry.filepath,
						display = entry.task,
						ordinal = entry.task,
						path = entry.path,
						lnum = entry.line_number,
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
		})
		:find()
end

return M
