
local query_estimate = function()
  -- Will perform a dry run of the query in the buffer then parse and notify the
  -- results to the user
  -- Create a temporary file to save the buffer too
  local temp_file = '/tmp/bq_query_' .. os.time() .. '.sql'
  -- Get current buffer content and write to temp file
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local file = io.open(temp_file, 'w')
  file:write(table.concat(lines, '\n'))
  file:close()

  local cmd = string.format('bq query --use_legacy_sql=false --dry_run "$(cat %s)"', temp_file)
  -- Set up job options (use jobs to prevent command from freezing UI)
  local job_opts = {
    on_stdout = function(_, data)
      if not data then
        return
      end

      local output = table.concat(data, '\n')
      -- Only proceed if output is not empty
      if output and output ~= '' then
        vim.schedule(function()
          -- Check if it's an error message first
          if string.find(output, 'Error in query string') then
            vim.notify(output, 'error')
          else
            -- Parse the bytes figure from the output
            local bytes = string.match(output, '%s(%d+)%s')
            if bytes == nil then
              vim.notify('Failed to parse bytes: ' .. output, vim.log.levels.ERROR)
              return
            end
            local query_cost = bytes / 1024 / 1024 / 1024
            -- Regular output notification
            vim.notify(string.format('Query cost: %.2f GB', query_cost))
          end
        end)
      end
    end,
    on_stderr = function(_, data)
      if data then
        -- Handle any errors
        local error_msg = table.concat(data, '\n')
        if error_msg ~= '' then
          vim.schedule(function()
            vim.notify(error_msg, 'error')
          end)
        end
      end
    end,
    on_exit = function()
      -- Clean up the temporary file
      vim.schedule(function()
        os.remove(temp_file)
      end)
    end,
  }
  -- Start the job
  vim.fn.jobstart({ 'sh', '-c', cmd }, job_opts)
end

vim.api.nvim_create_user_command('QueryCost', query_estimate, {})
local group = vim.api.nvim_create_augroup('SQLQueryEstimate', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = group,
  pattern = '*.sql',
  callback = function()
    query_estimate()
  end,
  desc = 'Estimate query cost after saving SQL file',
})

local dataform_query_compile = function()
  -- Get current buffer content
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local config_text = table.concat(lines, '\n')

  -- Try to find name in config block
  local config_name = config_text:match 'config%s*{.-name:%s*"([^"]+)".-}'

  -- Get the current buffer's filename as fallback
  local current_file = vim.fn.expand '%:t'
  local file_name = current_file:gsub('%..*$', '')

  -- Use config name if found, otherwise use filename
  local table_name = config_name or file_name
  local command = string.format('dataform compile --json 2>/dev/null | jq -r \'.tables | .[] | select(.target.name == "%s") | .query\'', table_name)
  local content = vim.fn.system(command)
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, vim.split(content, '\n'))
  vim.api.nvim_command 'vsplit'
  vim.api.nvim_win_set_buf(0, bufnr)
  vim.bo[bufnr].filetype = 'sql'
end
vim.api.nvim_create_user_command('CompileQuery', dataform_query_compile, {})

-- Function to run BigQuery on current buffer
function RunBigQueryBuffer()
  -- Generate unique temp file name
  local temp_file = '/tmp/bq_query_' .. os.time() .. '.sql'

  -- Get current buffer content and write to temp file
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local file = io.open(temp_file, 'w')
  file:write(table.concat(lines, '\n'))
  file:close()

  local cmd = string.format('bq query --use_legacy_sql=false "$(cat %s)"', temp_file)
  local content = vim.fn.system(cmd)
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, vim.split(content, '\n'))
  vim.api.nvim_command 'split'
  local win = vim.api.nvim_get_current_win()
  vim.wo[win].wrap = false
  vim.api.nvim_win_set_buf(win, bufnr)

  -- Delete the temp file
  os.remove(temp_file)
end

-- Create user command
v
