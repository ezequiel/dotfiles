return {
  'rachartier/tiny-glimmer.nvim',
  priority = 10,
  opts = {
    overwrite = {
      search = {
        enabled = false,
      },
      undo = {
        enabled = true,
        default_animation = {
          settings = {
            max_duration = 750,
            min_duration = 750,
          },
        },
      },
      redo = {
        enabled = true,
        default_animation = {
          settings = {
            max_duration = 750,
            min_duration = 750,
          },
        },
      },
    },
    animations = {
      fade = {
        min_duration = 750,
        max_duration = 750,
      },
      reverse_fade = {
        max_duration = 750,
        min_duration = 750,
      },
    },
  },
}
