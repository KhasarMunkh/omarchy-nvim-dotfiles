return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'mason-org/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Language Adapters
        'leoluz/nvim-dap-go',
        'mfussenegger/nvim-dap-python',
        -- JavaScript/TypeScript (Node)
        'mxsdev/nvim-dap-vscode-js',
        'microsoft/vscode-js-debug',
    },
    keys = {
        -- Basic debugging keymaps, feel free to change to your liking!
        {
            '<F5>',
            function()
                require('dap').continue()
            end,
            desc = 'Debug: Start/Continue',
        },
        {
            '<F1>',
            function()
                require('dap').step_into()
            end,
            desc = 'Debug: Step Into',
        },
        {
            '<F2>',
            function()
                require('dap').step_over()
            end,
            desc = 'Debug: Step Over',
        },
        {
            '<F3>',
            function()
                require('dap').step_out()
            end,
            desc = 'Debug: Step Out',
        },
        {
            '<leader>b',
            function()
                require('dap').toggle_breakpoint()
            end,
            desc = 'Debug: Toggle Breakpoint',
        },
        {
            '<leader>B',
            function()
                require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end,
            desc = 'Debug: Set Breakpoint',
        },
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        {
            '<F7>',
            function()
                require('dapui').toggle()
            end,
            desc = 'Debug: See last session result.',
        },
        -- Run current file with DAP, language-aware
        -- This will run the current file with the appropriate DAP configuration based on the filetype
        -- For Python, it uses the Python DAP adapter.
        -- For JavaScript/TypeScript, it uses the Node.js DAP adapter.
        -- If the filetype is not supported, it will notify you.
        {
          '<leader>rf',
          function()
            local dap = require('dap')
            local ft = vim.bo.filetype
            if ft == 'python' then
              dap.run({
                type = 'python',
                request = 'launch',
                name = 'Python: Run file',
                program = '${file}',
                console = 'integratedTerminal',
                pythonPath = function() return vim.fn.exepath('python') end, -- venv-aware
              })
            elseif ft == 'javascript' or ft == 'javascriptreact' or ft == 'typescript' or ft == 'typescriptreact' then
              dap.run({
                type = 'pwa-node',
                request = 'launch',
                name = 'Node: Launch file',
                program = '${file}',
                cwd = '${workspaceFolder}',
                runtimeExecutable = 'node',
                console = 'integratedTerminal',
              })
            else
              vim.notify('No DAP config for filetype: ' .. ft, vim.log.levels.WARN)
            end
          end,
          desc = 'DAP: Run current file (lang-aware)',
        },
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'delve',
                'js-debug-adapter',
                'python',
                'node-debug2-adapter',
                'codelldb',
            },
        }

        dapui.setup {
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Install golang specific config
        require('dap-go').setup {
            delve = {
                -- On Windows delve must be run attached or it crashes.
                -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
                detached = vim.fn.has 'win32' == 0,
            },
        }
    end,
}
