vim.g.mapleader = ' ' -- make sure to set `mapleader` before lazy so your mappings are correct

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Default mappings. Feel free to modify or remove as you wish.
  --
  -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'bd', api.marks.bulk.delete, opts('Delete Bookmarked'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
  vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
  vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
  -- END_DEFAULT_ON_ATTACH

  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.edit, opts('Open'))
end

local nvim_tree_setup = function()
  require('nvim-tree').setup({
    on_attach = on_attach,
    diagnostics = {
      enable = true,
    },
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    respect_buf_cwd = false,
    sync_root_with_cwd = false,
    view = {
      width = 40,
      side = 'right',
      --mappings = {
      --  custom_only = false,
      --  list = {
      --    { key = { '<CR>', '<Tab>' }, action = 'edit' },
      --  },
      --},
    },
  })
end

local nt_config = {
  -- If a user has a sources list it will replace this one.
  -- Only sources listed here will be loaded.
  -- You can also add an external source by adding it's name to this list.
  -- The name used here must be the same name you would use in a require() call.
  sources = {
    'filesystem',
    'buffers',
    'git_status',
    -- "document_symbols",
  },
  add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
  auto_clean_after_session_restore = false, -- Automatically clean up broken neo-tree buffers saved in sessions
  close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
  default_source = 'filesystem', -- you can choose a specific source `last` here which indicates the last used source
  enable_diagnostics = true,
  enable_git_status = true,
  enable_modified_markers = true, -- Show markers for files with unsaved changes.
  enable_opened_markers = true, -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
  enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
  enable_cursor_hijack = false, -- If enabled neotree will keep the cursor on the first letter of the filename when moving in the tree.
  git_status_async = true,
  -- These options are for people with VERY large git repos
  git_status_async_options = {
    batch_size = 1000, -- how many lines of git status results to process at a time
    batch_delay = 10, -- delay in ms between batches. Spreads out the workload to let other processes run.
    max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
    -- Anything before this will be used. The last items to be processed are the untracked files.
  },
  hide_root_node = false, -- Hide the root node.
  retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
  -- This is needed if you use expanders because they render in the indent.
  log_level = 'info', -- "trace", "debug", "info", "warn", "error", "fatal"
  log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
  open_files_in_last_window = true, -- false = open files in top left window
  open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'edgy' }, -- when opening files, do not use windows containing these filetypes or buftypes
  -- popup_border_style is for input and confirmation dialogs.
  -- Configurtaion of floating window is done in the individual source sections.
  -- "NC" is a special style that works well with NormalNC set
  popup_border_style = 'NC', -- "double", "none", "rounded", "shadow", "single" or "solid"
  resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
  -- set to -1 to disable the resize timer entirely
  --                           -- NOTE: this will speed up to 50 ms for 1 second following a resize
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  sort_function = nil, -- uses a custom function for sorting files and directories in the tree
  use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
  use_default_mappings = true,
  -- source_selector provides clickable tabs to switch between sources.
  source_selector = {
    winbar = false, -- toggle to show selector on winbar
    statusline = false, -- toggle to show selector on statusline
    show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
    -- of the top visible node when scrolled down.
    sources = {
      { source = 'filesystem' },
      { source = 'buffers' },
      { source = 'git_status' },
    },
    content_layout = 'start', -- only with `tabs_layout` = "equal", "focus"
    --                start  : |/ 󰓩 bufname     \/...
    --                end    : |/     󰓩 bufname \/...
    --                center : |/   󰓩 bufname   \/...
    tabs_layout = 'equal', -- start, end, center, equal, focus
    --             start  : |/  a  \/  b  \/  c  \            |
    --             end    : |            /  a  \/  b  \/  c  \|
    --             center : |      /  a  \/  b  \/  c  \      |
    --             equal  : |/    a    \/    b    \/    c    \|
    --             active : |/  focused tab    \/  b  \/  c  \|
    truncation_character = '…', -- character to use when truncating the tab label
    tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
    tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
    padding = 0, -- can be int or table
    -- padding = { left = 2, right = 0 },
    -- separator = "▕", -- can be string or table, see below
    separator = { left = '▏', right = '▕' },
    -- separator = { left = "/", right = "\\", override = nil },     -- |/  a  \/  b  \/  c  \...
    -- separator = { left = "/", right = "\\", override = "right" }, -- |/  a  \  b  \  c  \...
    -- separator = { left = "/", right = "\\", override = "left" },  -- |/  a  /  b  /  c  /...
    -- separator = { left = "/", right = "\\", override = "active" },-- |/  a  / b:active \  c  \...
    -- separator = "|",                                              -- ||  a  |  b  |  c  |...
    separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
    show_separator_on_edge = false,
    --                       true  : |/    a    \/    b    \/    c    \|
    --                       false : |     a    \/    b    \/    c     |
    highlight_tab = 'NeoTreeTabInactive',
    highlight_tab_active = 'NeoTreeTabActive',
    highlight_background = 'NeoTreeTabInactive',
    highlight_separator = 'NeoTreeTabSeparatorInactive',
    highlight_separator_active = 'NeoTreeTabSeparatorActive',
  },
  --
  --event_handlers = {
  --  {
  --    event = "before_render",
  --    handler = function (state)
  --      -- add something to the state that can be used by custom components
  --    end
  --  },
  --  {
  --    event = "file_opened",
  --    handler = function(file_path)
  --      --auto close
  --      require("neo-tree.command").execute({ action = "close" })
  --    end
  --  },
  --  {
  --    event = "file_opened",
  --    handler = function(file_path)
  --      --clear search after opening a file
  --      require("neo-tree.sources.filesystem").reset_search()
  --    end
  --  },
  --  {
  --    event = "file_renamed",
  --    handler = function(args)
  --      -- fix references to file
  --      print(args.source, " renamed to ", args.destination)
  --    end
  --  },
  --  {
  --    event = "file_moved",
  --    handler = function(args)
  --      -- fix references to file
  --      print(args.source, " moved to ", args.destination)
  --    end
  --  },
  --  {
  --    event = "neo_tree_buffer_enter",
  --    handler = function()
  --      vim.cmd 'highlight! Cursor blend=100'
  --    end
  --  },
  --  {
  --    event = "neo_tree_buffer_leave",
  --    handler = function()
  --      vim.cmd 'highlight! Cursor guibg=#5f87af blend=0'
  --    end
  --  },
  -- {
  --   event = "neo_tree_window_before_open",
  --   handler = function(args)
  --     print("neo_tree_window_before_open", vim.inspect(args))
  --   end
  -- },
  -- {
  --   event = "neo_tree_window_after_open",
  --   handler = function(args)
  --     vim.cmd("wincmd =")
  --   end
  -- },
  -- {
  --   event = "neo_tree_window_before_close",
  --   handler = function(args)
  --     print("neo_tree_window_before_close", vim.inspect(args))
  --   end
  -- },
  -- {
  --   event = "neo_tree_window_after_close",
  --   handler = function(args)
  --     vim.cmd("wincmd =")
  --   end
  -- }
  --},
  default_component_configs = {
    container = {
      enable_character_fade = true,
      width = '100%',
      right_padding = 0,
    },
    --diagnostics = {
    --  symbols = {
    --    hint = "H",
    --    info = "I",
    --    warn = "!",
    --    error = "X",
    --  },
    --  highlights = {
    --    hint = "DiagnosticSignHint",
    --    info = "DiagnosticSignInfo",
    --    warn = "DiagnosticSignWarn",
    --    error = "DiagnosticSignError",
    --  },
    --},
    indent = {
      indent_size = 2,
      padding = 1,
      -- indent guides
      with_markers = true,
      indent_marker = '│',
      last_indent_marker = '└',
      highlight = 'NeoTreeIndentMarker',
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = '',
      expander_expanded = '',
      expander_highlight = 'NeoTreeExpander',
    },
    icon = {
      folder_closed = '',
      folder_open = '',
      folder_empty = '󰉖',
      folder_empty_open = '󰷏',
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = '*',
      highlight = 'NeoTreeFileIcon',
    },
    modified = {
      symbol = '[+] ',
      highlight = 'NeoTreeModified',
    },
    name = {
      trailing_slash = false,
      highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
      -- Take values in { false (no highlight), true (only loaded),
      -- "all" (both loaded and unloaded)}. For more information,
      -- see the `show_unloaded` config of the `buffers` source.
      use_git_status_colors = true,
      highlight = 'NeoTreeFileName',
    },
    git_status = {
      symbols = {
        -- Change type
        added = '✚', -- NOTE: you can set any of these to an empty string to not show them
        deleted = '✖',
        modified = '',
        renamed = '󰁕',
        -- Status type
        untracked = '',
        ignored = '',
        unstaged = '󰄱',
        staged = '',
        conflict = '',
      },
      align = 'right',
    },
    -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
    file_size = {
      enabled = false,
      required_width = 40, -- min width of window required to show this column
    },
    type = {
      enabled = false,
      required_width = 40, -- min width of window required to show this column
    },
    last_modified = {
      enabled = true,
      required_width = 40, -- min width of window required to show this column
    },
    created = {
      enabled = false,
      required_width = 120, -- min width of window required to show this column
    },
    symlink_target = {
      enabled = false,
    },
  },
  renderers = {
    directory = {
      { 'indent' },
      { 'icon' },
      { 'current_filter' },
      {
        'container',
        content = {
          { 'name', zindex = 10 },
          {
            'symlink_target',
            zindex = 10,
            highlight = 'NeoTreeSymbolicLinkTarget',
          },
          { 'clipboard', zindex = 10 },
          { 'diagnostics', errors_only = true, zindex = 20, align = 'right', hide_when_expanded = true },
          { 'git_status', zindex = 10, align = 'right', hide_when_expanded = true },
          { 'file_size', zindex = 10, align = 'right' },
          { 'type', zindex = 10, align = 'right' },
          { 'last_modified', zindex = 10, align = 'right' },
          { 'created', zindex = 10, align = 'right' },
        },
      },
    },
    file = {
      { 'indent' },
      { 'icon' },
      {
        'container',
        content = {
          {
            'name',
            zindex = 10,
          },
          {
            'symlink_target',
            zindex = 10,
            highlight = 'NeoTreeSymbolicLinkTarget',
          },
          { 'clipboard', zindex = 10 },
          { 'bufnr', zindex = 10 },
          { 'modified', zindex = 20, align = 'right' },
          { 'diagnostics', zindex = 20, align = 'right' },
          { 'git_status', zindex = 10, align = 'right' },
          { 'file_size', zindex = 10, align = 'right' },
          { 'type', zindex = 10, align = 'right' },
          { 'last_modified', zindex = 10, align = 'right' },
          { 'created', zindex = 10, align = 'right' },
        },
      },
    },
    message = {
      { 'indent', with_markers = false },
      { 'name', highlight = 'NeoTreeMessage' },
    },
    terminal = {
      { 'indent' },
      { 'icon' },
      { 'name' },
      { 'bufnr' },
    },
  },
  nesting_rules = {},
  -- Global custom commands that will be available in all sources (if not overridden in `opts[source_name].commands`)
  --
  -- You can then reference the custom command by adding a mapping to it:
  --    globally    -> `opts.window.mappings`
  --    locally     -> `opt[source_name].window.mappings` to make it source specific.
  --
  -- commands = {              |  window {                 |  filesystem {
  --   hello = function()      |    mappings = {           |    commands = {
  --     print("Hello world")  |      ["<C-c>"] = "hello"  |      hello = function()
  --   end                     |    }                      |        print("Hello world in filesystem")
  -- }                         |  }                        |      end
  --
  -- see `:h neo-tree-custom-commands-global`
  commands = {}, -- A list of functions

  window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
    -- possible options. These can also be functions that return these options.
    position = 'right', -- left, right, top, bottom, float, current
    width = 50, -- applies to left and right positions
    height = 15, -- applies to top and bottom positions
    auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
    popup = { -- settings that apply to float position only
      size = {
        height = '80%',
        width = '50%',
      },
      position = '50%', -- 50% means center it
      -- you can also specify border here, if you want a different setting from
      -- the global popup_border_style.
    },
    same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
    insert_as = 'child', -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
    -- "child":   Insert nodes as children of the directory under cursor.
    -- "sibling": Insert nodes  as siblings of the directory under cursor.
    -- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
    -- You can also create your own commands by providing a function instead of a string.
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ['<space>'] = {
        'toggle_node',
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ['<2-LeftMouse>'] = 'open',
      ['<cr>'] = 'open',
      ['<tab>'] = 'open',
      -- ["<cr>"] = { "open", config = { expand_nested_files = true } }, -- expand nested file takes precedence
      ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
      ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = false } },
      ['<C-f>'] = { 'scroll_preview', config = { direction = -10 } },
      ['<C-b>'] = { 'scroll_preview', config = { direction = 10 } },
      ['l'] = 'focus_preview',
      ['S'] = 'open_split',
      -- ["S"] = "split_with_window_picker",
      ['s'] = 'open_vsplit',
      -- ["sr"] = "open_rightbelow_vs",
      -- ["sl"] = "open_leftabove_vs",
      -- ["s"] = "vsplit_with_window_picker",
      ['t'] = 'open_tabnew',
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ['w'] = 'open_with_window_picker',
      ['C'] = 'close_node',
      ['z'] = 'close_all_nodes',
      --["Z"] = "expand_all_nodes",
      ['R'] = 'refresh',
      ['a'] = {
        'add',
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = 'none', -- "none", "relative", "absolute"
        },
      },
      ['A'] = 'add_directory', -- also accepts the config.show_path and config.insert_as options.
      ['d'] = 'delete',
      ['r'] = 'rename',
      ['y'] = 'copy_to_clipboard',
      ['x'] = 'cut_to_clipboard',
      ['p'] = 'paste_from_clipboard',
      ['c'] = 'copy', -- takes text input for destination, also accepts the config.show_path and config.insert_as options
      ['m'] = 'move', -- takes text input for destination, also accepts the config.show_path and config.insert_as options
      ['e'] = 'toggle_auto_expand_width',
      ['q'] = 'close_window',
      ['?'] = 'show_help',
      ['<'] = 'prev_source',
      ['>'] = 'next_source',
    },
  },
  filesystem = {
    window = {
      mappings = {
        ['H'] = 'toggle_hidden',
        ['/'] = 'fuzzy_finder',
        ['D'] = 'fuzzy_finder_directory',
        --["/"] = "filter_as_you_type", -- this was the default until v1.28
        ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ['f'] = 'filter_on_submit',
        ['<C-x>'] = 'clear_filter',
        ['<bs>'] = 'navigate_up',
        ['.'] = 'set_root',
        ['[g'] = 'prev_git_modified',
        [']g'] = 'next_git_modified',
        ['i'] = 'show_file_details',
        ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
        ['oc'] = { 'order_by_created', nowait = false },
        ['od'] = { 'order_by_diagnostics', nowait = false },
        ['og'] = { 'order_by_git_status', nowait = false },
        ['om'] = { 'order_by_modified', nowait = false },
        ['on'] = { 'order_by_name', nowait = false },
        ['os'] = { 'order_by_size', nowait = false },
        ['ot'] = { 'order_by_type', nowait = false },
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ['<down>'] = 'move_cursor_down',
        ['<C-n>'] = 'move_cursor_down',
        ['<up>'] = 'move_cursor_up',
        ['<C-p>'] = 'move_cursor_up',
      },
    },
    async_directory_scan = 'auto', -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
    -- "always" means directory scans are always async.
    -- "never"  means directory scans are never async.
    scan_mode = 'shallow', -- "shallow": Don't scan into directories to detect possible empty directory a priori
    -- "deep": Scan into directories to detect empty or grouped empty directories a priori.
    bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
    cwd_target = {
      sidebar = 'tab', -- sidebar is when position = left or right
      current = 'window', -- current is when position = current
    },
    check_gitignore_in_search = true, -- check gitignore status for files/directories when searching
    -- setting this to false will speed up searches, but gitignored
    -- items won't be marked if they are visible.
    -- The renderer section provides the renderers that will be used to render the tree.
    --   The first level is the node type.
    --   For each node type, you can specify a list of components to render.
    --       Components are rendered in the order they are specified.
    --         The first field in each component is the name of the function to call.
    --         The rest of the fields are passed to the function as the "config" argument.
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
      show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = true, -- only works on Windows for hidden files/directories
      hide_by_name = {
        '.DS_Store',
        'thumbs.db',
        --"node_modules",
      },
      hide_by_pattern = { -- uses glob style patterns
        --"*.meta",
        --"*/src/*/tsconfig.json"
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
    find_by_full_path_words = false, -- `false` means it only searches the tail of a path.
    -- `true` will change the filter into a full path
    -- search with space as an implicit ".*", so
    -- `fi init`
    -- will match: `./sources/filesystem/init.lua
    --find_command = "fd", -- this is determined automatically, you probably don't need to set it
    --find_args = {  -- you can specify extra args to pass to the find command.
    --  fd = {
    --  "--exclude", ".git",
    --  "--exclude",  "node_modules"
    --  }
    --},
    ---- or use a function instead of list of strings
    --find_args = function(cmd, path, search_term, args)
    --  if cmd ~= "fd" then
    --    return args
    --  end
    --  --maybe you want to force the filter to always include hidden files:
    --  table.insert(args, "--hidden")
    --  -- but no one ever wants to see .git files
    --  table.insert(args, "--exclude")
    --  table.insert(args, ".git")
    --  -- or node_modules
    --  table.insert(args, "--exclude")
    --  table.insert(args, "node_modules")
    --  --here is where it pays to use the function, you can exclude more for
    --  --short search terms, or vary based on the directory
    --  if string.len(search_term) < 4 and path == "/home/cseickel" then
    --    table.insert(args, "--exclude")
    --    table.insert(args, "Library")
    --  end
    --  return args
    --end,
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    search_limit = 50, -- max number of search results when using filters
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --               -- the current file is changed while the tree is open.
      leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- "open_current",-- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
  },
  buffers = {
    bind_to_cwd = true,
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --              -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = true, -- when true, empty directories will be grouped together
    show_unloaded = false, -- When working with sessions, for example, restored but unfocused buffers
    -- are mark as "unloaded". Turn this on to view these unloaded buffer.
    terminals_first = false, -- when true, terminals will be listed before file buffers
    window = {
      mappings = {
        ['<bs>'] = 'navigate_up',
        ['.'] = 'set_root',
        ['bd'] = 'buffer_delete',
        ['i'] = 'show_file_details',
        ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
        ['oc'] = { 'order_by_created', nowait = false },
        ['od'] = { 'order_by_diagnostics', nowait = false },
        ['om'] = { 'order_by_modified', nowait = false },
        ['on'] = { 'order_by_name', nowait = false },
        ['os'] = { 'order_by_size', nowait = false },
        ['ot'] = { 'order_by_type', nowait = false },
      },
    },
  },
  git_status = {
    window = {
      mappings = {
        ['A'] = 'git_add_all',
        ['gu'] = 'git_unstage_file',
        ['ga'] = 'git_add_file',
        ['gr'] = 'git_revert_file',
        ['gc'] = 'git_commit',
        ['gp'] = 'git_push',
        ['gg'] = 'git_commit_and_push',
        ['i'] = 'show_file_details',
        ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
        ['oc'] = { 'order_by_created', nowait = false },
        ['od'] = { 'order_by_diagnostics', nowait = false },
        ['om'] = { 'order_by_modified', nowait = false },
        ['on'] = { 'order_by_name', nowait = false },
        ['os'] = { 'order_by_size', nowait = false },
        ['ot'] = { 'order_by_type', nowait = false },
      },
    },
  },
  document_symbols = {
    follow_cursor = false,
    client_filters = 'first',
    renderers = {
      root = {
        { 'indent' },
        { 'icon', default = 'C' },
        { 'name', zindex = 10 },
      },
      symbol = {
        { 'indent', with_expanders = true },
        { 'kind_icon', default = '?' },
        {
          'container',
          content = {
            { 'name', zindex = 10 },
            { 'kind_name', zindex = 20, align = 'right' },
          },
        },
      },
    },
    window = {
      mappings = {
        ['<cr>'] = 'jump_to_symbol',
        ['o'] = 'jump_to_symbol',
        ['A'] = 'noop', -- also accepts the config.show_path and config.insert_as options.
        ['d'] = 'noop',
        ['y'] = 'noop',
        ['x'] = 'noop',
        ['p'] = 'noop',
        ['c'] = 'noop',
        ['m'] = 'noop',
        ['a'] = 'noop',
        ['/'] = 'filter',
        ['f'] = 'filter_on_submit',
      },
    },
    custom_kinds = {
      -- define custom kinds here (also remember to add icon and hl group to kinds)
      -- ccls
      -- [252] = 'TypeAlias',
      -- [253] = 'Parameter',
      -- [254] = 'StaticMethod',
      -- [255] = 'Macro',
    },
    kinds = {
      Unknown = { icon = '?', hl = '' },
      Root = { icon = '', hl = 'NeoTreeRootName' },
      File = { icon = '󰈙', hl = 'Tag' },
      Module = { icon = '', hl = 'Exception' },
      Namespace = { icon = '󰌗', hl = 'Include' },
      Package = { icon = '󰏖', hl = 'Label' },
      Class = { icon = '󰌗', hl = 'Include' },
      Method = { icon = '', hl = 'Function' },
      Property = { icon = '󰆧', hl = '@property' },
      Field = { icon = '', hl = '@field' },
      Constructor = { icon = '', hl = '@constructor' },
      Enum = { icon = '󰒻', hl = '@number' },
      Interface = { icon = '', hl = 'Type' },
      Function = { icon = '󰊕', hl = 'Function' },
      Variable = { icon = '', hl = '@variable' },
      Constant = { icon = '', hl = 'Constant' },
      String = { icon = '󰀬', hl = 'String' },
      Number = { icon = '󰎠', hl = 'Number' },
      Boolean = { icon = '', hl = 'Boolean' },
      Array = { icon = '󰅪', hl = 'Type' },
      Object = { icon = '󰅩', hl = 'Type' },
      Key = { icon = '󰌋', hl = '' },
      Null = { icon = '', hl = 'Constant' },
      EnumMember = { icon = '', hl = 'Number' },
      Struct = { icon = '󰌗', hl = 'Type' },
      Event = { icon = '', hl = 'Constant' },
      Operator = { icon = '󰆕', hl = 'Operator' },
      TypeParameter = { icon = '󰊄', hl = 'Type' },

      -- ccls
      -- TypeAlias = { icon = ' ', hl = 'Type' },
      -- Parameter = { icon = ' ', hl = '@parameter' },
      -- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
      -- Macro = { icon = ' ', hl = 'Macro' },
    },
  },
  example = {
    renderers = {
      custom = {
        { 'indent' },
        { 'icon', default = 'C' },
        { 'custom' },
        { 'name' },
      },
    },
    window = {
      mappings = {
        ['<cr>'] = 'toggle_node',
        ['<C-e>'] = 'example_command',
        ['d'] = 'show_debug_info',
      },
    },
  },
}

require('lazy').setup({
  'folke/which-key.nvim',
  'folke/neodev.nvim',
  {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup({})
    end,
  },
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup({})
    end,
  },
  'kdheepak/lazygit.nvim',
  {
    'morhetz/gruvbox',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    'FabijanZulj/blame.nvim',
    config = function()
      require('blame').setup()
    end,
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({})
    end,
  },
  { 'sbdchd/neoformat' },
  { 'preservim/tagbar' },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'UIEnter' },
    config = function()
      require('hlchunk').setup({
        support_filetypes = {
          '*.lua',
          '*.rs',
        },
        chunk = {
          chars = {
            horizontal_line = '─',
            vertical_line = '│',
            left_top = '╭',
            left_bottom = '╰',
            right_arrow = '>',
          },
          style = '#806d9c',
        },
      })
    end,
  },
  { 'mboughaba/i3config.vim' },
  --[[
  "nvim-lua/lsp-status.nvim")
  "arkav/lualine-lsp-progress")
  "nvim-lua/popup.nvim")
  --]]
  { 'nvim-lua/plenary.nvim' },
  { 'famiu/bufdelete.nvim' }, -- required so nvim-tree doesn't stay open when you close the buffer
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'python',
          'rust',
          'yaml',
          'lua',
          'toml',
          'regex',
          'html',
          'css',
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },
  -- { 'RishabhRD/popfix' },
  { 'wesleimp/stylua.nvim' },
  { 'mrcjkb/rustaceanvim', version = '^4', ft = { 'rust' } },
  --[[
  {
    'nvim-tree/nvim-tree.lua',
    config = nvim_tree_setup,
  },
  ]]
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = nt_config,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup()
    end,
  },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('mason-lspconfig').setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup({})
          print('loaded lsp server ' .. server_name)
        end,
        -- Next, you can provide targeted overrides for specific servers.
        ['lua_ls'] = function()
          print('loaded lsp server lua_ls')
          local settings = {
            Lua = {
              diagnostics = {
                -- GAHH this has to be single-quoted
                globals = { 'vim' },
              },
            },
          }
          require('lspconfig')['lua_ls'].setup({ settings = settings })
        end,
        -- For example, a handler override for the `rust_analyzer`:
        ['rust_analyzer'] = function()
          print('loaded lsp server rust-analyzer')
          local tools = {
            inlay_hints = {
              auto = false, -- inlay hints are native in nvim greater than some 0.10 version!
            },
            runnables = { use_telescope = true },
            -- inlay_hints = { show_parameter_hints = true },
            hover_actions = { auto_focus = true },
          }

          --          require('rust-tools').setup({
          --            tools = tools,
          --            server = {
          --              flags = { debounce_text_changes = 150 },
          --              settings = {
          --                ['rust-analyzer'] = {
          --                  checkOnSave = {
          --                    allFeatures = true,
          --                    overrideCommand = {
          --                      'cargo',
          --                      'clippy',
          --                      '--workspace',
          --                      '--message-format=json',
          --                      '--all-targets',
          --                      '--all-features',
          --                    },
          --                  },
          --                },
          --              },
          --            },
          --          })
        end,
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    --tag = 'legacy',
    config = function()
      require('fidget').setup({
        notification = {
          window = {
            relative = 'win',
          },
        },
      })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup({
        highlights = {
          buffer_selected = {
            fg = {
              attribute = 'bg',
              highlight = 'Normal',
            },
            bg = {
              attribute = 'fg',
              highlight = 'Normal',
            },
          },
          close_button_selected = {
            fg = {
              attribute = 'bg',
              highlight = 'Normal',
            },
            bg = {
              attribute = 'fg',
              highlight = 'Normal',
            },
          },
        },
        options = {
          close_command = 'bdelete! %d',
          tab_size = 18,
          enforce_regular_tabs = true,
          diagnostics = 'nvim_lsp',
          offsets = {
            {
              filetype = 'NvimTree',
              text = function()
                return vim.fn.getcwd()
              end,
              text_align = 'left',
            },
          },
        },
      })
    end,
  },
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        enable_check_bracket_line = false,
      })
    end,
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        --{ 'hrsh7th/cmp-vsnip', commit = '1ae05c6' },
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
      },
      config = function()
        local cmp = require('cmp')
        cmp.setup({
          -- Enable LSP snippets
          snippet = {
            expand = function(args)
              -- vim.fn['vsnip#anonymous'](args.body) -- vsnip broke ('unknown function vsnip#anonymous')
              require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
          },
          mapping = {
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            -- Add tab support
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-u>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }),
          },

          -- Installed sources
          sources = {
            { name = 'nvim_lsp' },
            -- { name = 'vsnip' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' },
          },
        })
      end,
    },
  },
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
    config = function()
      vim.api.nvim_set_keymap('n', 'ga', '<cmd>CodeActionMenu<CR>', { silent = true })
    end,
  },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
    end,
  },
  -- starts
  {
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.dashboard').config)
    end,
  },
  --{
  --  'Shatur/neovim-session-manager',
  --  config = function()
  --    local Path = require('plenary.path')
  --    local opts = {
  --      sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
  --      path_replacer = '__', -- The character to which the path separator will be replaced for session files.
  --      colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
  --      autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
  --      autosave_last_session = true, -- Automatically save last session on exit and on session switch.
  --      autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
  --      autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
  --      autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
  --        'gitcommit',
  --      },
  --      autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
  --      autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
  --      max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
  --    }
  --    require('session_manager').setup(opts)
  --  end,
  --},
  --{ 'mhinz/vim-startify' },
  { 'mbbill/undotree' },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          theme = 'gruvbox',
          lower = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'filename', file_status = true, path = 2 },
            'branch',
            { 'diagnostics', sources = { 'nvim_diagnostic' } },
          },
          --lualine_c = { "lsp_progress" },
          lualine_c = {},
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = {
          'nvim-tree',
          'quickfix',
        },
      })
    end,
  },
  {
    'jim-fx/sudoku.nvim',
    config = function()
      require('sudoku').setup({
        persist_settings = true, -- safe the settings under vim.fn.stdpath("data"), usually ~/.local/share/nvim,
        persist_games = true, -- persist a history of all played games
        default_mappings = true, -- if set to false you need to set your own, like the following:
        mappings = {
          { key = 'x', action = 'clear_cell' },
          { key = 'r1', action = 'insert=1' },
          { key = 'r2', action = 'insert=2' },
          { key = 'r3', action = 'insert=3' },
          -- ...
          { key = 'r9', action = 'insert=9' },
          { key = 'gn', action = 'new_game' },
          { key = 'gr', action = 'reset_game' },
          { key = 'gs', action = 'view=settings' },
          { key = 'gt', action = 'view=tip' },
          { key = 'gz', action = 'view=zen' },
          { key = 'gh', action = 'view=help' },
          { key = 'u', action = 'undo' },
          { key = '<C-r>', action = 'redo' },
          { key = '+', action = 'increment' },
          { key = '-', action = 'decrement' },
        },
      })
    end,
  },
  {
    'skosulor/nibbler',
    config = function()
      require('nibbler').setup({
        display_enabled = true, -- Set to false to disable real-time display (default: true)
      })
    end,
  },
  {
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup()
    end,
  },
}) -- end lazy setup
