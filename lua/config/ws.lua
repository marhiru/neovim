local M = {}

-- Utility: parse WS url from current .http buffer
local function get_ws_url_from_buffer()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        local url = line:match("^WS%s+(wss?://[^%s]+)")
        if url then
            return url
        end
    end
    return nil
end

-- Utility: find or create a terminal buffer for a given url
local function find_ws_term_buf(url)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            local name = vim.api.nvim_buf_get_name(buf)
            if name:match("websocat") and name:match(vim.pesc(url)) then
                return buf
            end
        end
    end
    return nil
end

function M.setup()
    -- Open or focus an existing WS terminal
    vim.keymap.set("n", "<leader>wo", function()
        local url = get_ws_url_from_buffer()
        if not url then
            url = vim.fn.input("WS URL: ", "ws://localhost:3000/")
        end
        if url == "" then return end

        local existing = find_ws_term_buf(url)
        if existing then
            local win = vim.fn.bufwinid(existing)
            if win ~= -1 then
                vim.api.nvim_set_current_win(win)
                vim.cmd("startinsert")
                return
            else
                vim.cmd("vsplit")
                vim.api.nvim_set_current_buf(existing)
                vim.cmd("startinsert")
                return
            end
        end

        vim.cmd("split | terminal websocat -v " .. url)
        vim.cmd("startinsert")
    end, { desc = "WS: Open connection from .http or prompt" })

    -- Close the WS terminal
    vim.keymap.set("n", "<leader>wc", function()
        local url = get_ws_url_from_buffer()
        if not url then
            vim.notify("No WS URL found in buffer", vim.log.levels.WARN)
            return
        end

        local buf = find_ws_term_buf(url)
        if buf then
            vim.api.nvim_buf_delete(buf, { force = true })
            vim.notify("WS connection closed: " .. url, vim.log.levels.INFO)
        else
            vim.notify("No active WS connection for: " .. url, vim.log.levels.WARN)
        end
    end, { desc = "WS: Close connection" })

    -- Send a message
    vim.keymap.set("n", "<leader>we", function()
        local url = get_ws_url_from_buffer()
        if not url then
            url = vim.fn.input("WS URL: ", "ws://localhost:3000/")
        end
        if url == "" then return end

        local buf = find_ws_term_buf(url)
        if not buf then
            vim.notify("No active WS connection for: " .. url .. " — open one with <leader>wo", vim.log.levels.WARN)
            return
        end

        local msg = vim.fn.input("Send: ")
        if msg == "" then return end

        local chan = vim.api.nvim_buf_get_var(buf, "terminal_job_id")
        vim.api.nvim_chan_send(chan, msg .. "\n")
    end, { desc = "WS: Send message" })

    -- List all active WS connections
    vim.keymap.set("n", "<leader>wl", function()
        local conns = {}
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) then
                local name = vim.api.nvim_buf_get_name(buf)
                if name:match("websocat") then
                    table.insert(conns, string.format("buf %d: %s", buf, name))
                end
            end
        end

        if #conns == 0 then
            vim.notify("No active WS connections", vim.log.levels.INFO)
        else
            vim.notify("Active WS connections:\n" .. table.concat(conns, "\n"), vim.log.levels.INFO)
        end
    end, { desc = "WS: List active connections" })
end

return M
