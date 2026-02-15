return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		input = { enabled = true },
		picker = { enabled = true },
		image = {
			formats = {
				"png",
				"PNG",
				"jpg",
				"JPG",
				"jpeg",
				"gif",
				"bmp",
				"webp",
				"tiff",
				"heic",
				"HEIC",
				"avif",
				"mp4",
				"mov",
				"avi",
				"mkv",
				"webm",
				"pdf",
			},
			force = true, -- force displaying image in terminal
		},
	},
}
