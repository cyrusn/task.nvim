# Tasks

- Search all tasks on or before today
- tasks pattern looks like this
  - `- [ ] This is a task [scheduled:: 2024-01-21]`

# Installation

## Lazy

``` lua
return {
 "cyrusn/task.nvim",
 dependancies = {
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
 },
 keys = {
  {
   "<leader>st",
   function()
    require("task").search()
   end,
   desc = "Search today task",
  },
 },
 config = true,
}

```
