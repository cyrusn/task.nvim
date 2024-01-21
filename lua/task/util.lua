local M = {}

function M.warn(msg)
	vim.notify(msg, vim.log.levels.WARN, { title = "task.nvim" })
end

function M.error(msg)
	vim.notify(msg, vim.log.levels.ERROR, { title = "task.nvim" })
end

return M
