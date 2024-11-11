if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h10"
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_length = 0.2
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_transparency = 1.0
  vim.g.neovide_no_idle = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_fullscreen = false
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust" -- Options: torpedo, pixiedust, sonicboom, ripple, wireframe, railgun
  vim.g.neovide_cursor_vfx_opacity = 100.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 0.4
end
-- vim.o.linespace = 1
