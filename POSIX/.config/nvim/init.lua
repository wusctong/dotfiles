-- ============================================================
--  Bootstrap lazy.nvim
-- ============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
--  Options
-- ============================================================
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.termguicolors  = true
vim.opt.signcolumn     = "yes"
vim.opt.cursorline     = true
vim.opt.wrap           = false
vim.opt.scrolloff      = 8
vim.opt.showmode       = false

vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
vim.opt.smartindent = true

vim.opt.list      = true
vim.opt.listchars = { tab = "> " }

-- ============================================================
--  FileType autocmd: real tabs for tab-based languages
-- ============================================================
vim.api.nvim_create_autocmd("FileType", {
    pattern  = { "go", "make", "gitconfig", "asm" },
    callback = function()
        vim.opt_local.expandtab  = false
        vim.opt_local.tabstop    = 4
        vim.opt_local.shiftwidth = 4
    end,
})

-- ============================================================
--  LSP keymaps via LspAttach (replaces on_attach pattern)
--  Works with both old lspconfig and new vim.lsp.config API.
-- ============================================================
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local map   = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end
        map("gd",         vim.lsp.buf.definition,     "Go to Definition")
        map("gD",         vim.lsp.buf.declaration,    "Go to Declaration")
        map("gr",         vim.lsp.buf.references,     "References")
        map("gi",         vim.lsp.buf.implementation, "Implementation")
        map("K",          vim.lsp.buf.hover,          "Hover Docs")
        map("<leader>rn", vim.lsp.buf.rename,         "Rename")
        map("<leader>ca", vim.lsp.buf.code_action,    "Code Action")
        map("<leader>f",  function()
            vim.lsp.buf.format({ async = true })
        end, "Format")
    end,
})

-- ============================================================
--  Plugins via lazy.nvim
-- ============================================================
require("lazy").setup({
    -- ── Catppuccin theme ──────────────────────────────────────
    {
        "catppuccin/nvim",
        name     = "catppuccin",
        priority = 1000,
        opts = {
            flavour                = "mocha",
            transparent_background = false,
            integrations = {
                cmp        = true,
                gitsigns   = true,
                mason      = true,
                lualine    = true,
                treesitter = true,
                which_key  = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors      = { "underline" },
                        hints       = { "underline" },
                        warnings    = { "underline" },
                        information = { "underline" },
                    },
                },
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    -- ── Lualine ───────────────────────────────────────────────
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus         = true,
                    component_separators = "",
                    section_separators   = "",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },

    -- ── Mason ─────────────────────────────────────────────────
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts  = {
            ui = {
                icons = {
                    package_installed   = "✓",
                    package_pending     = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },

    -- ── nvim-lspconfig (new vim.lsp.config API, nvim-lspconfig >= 0.11) ───
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            -- Global defaults: capabilities for every server.
            -- Keymaps are handled by the LspAttach autocmd above.
            vim.lsp.config("*", {
                capabilities = vim.lsp.protocol.make_client_capabilities(),
            })

            -- Per-server overrides using the new vim.lsp.config() API.
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace   = { checkThirdParty = false },
                        telemetry   = { enable = false },
                    },
                },
            })
        end,
    },

    -- ── mason-lspconfig v2 ────────────────────────────────────
    -- v2 removed setup_handlers(); use the `handlers` key inside setup().
    -- handlers receive only real LSP server names, not formatters like stylua.
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed       = { "lua_ls", "pyright", "ts_ls", "gopls" },
                automatic_installation = true,
                handlers = {
                    -- Default: enable every installed LSP server.
                    function(server_name)
                        vim.lsp.enable(server_name)
                    end,
                },
            })
        end,
    },

    -- ── Completion ────────────────────────────────────────────
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp     = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
                        else fallback() end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then luasnip.jump(-1)
                        else fallback() end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip"  },
                    { name = "buffer"   },
                    { name = "path"     },
                }),
            })
        end,
    },

    -- ── Extras ────────────────────────────────────────────────
    { "windwp/nvim-autopairs",   event = "InsertEnter", config = true },
    { "numToStr/Comment.nvim",   opts  = {} },
    { "lewis6991/gitsigns.nvim", opts  = {} },
    { "folke/which-key.nvim",    event = "VeryLazy", opts = {} },

}, {
    ui = { border = "rounded" },
})

require("catppuccin").setup()
