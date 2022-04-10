-- In init.lua or filetype.nvim's config file
vim.filetype.add({
	extensions = {
		-- Set the filetype of *.pn files to potion
		fuse = "fuse",
	},
	pattern = {
		-- Set the filetype of any full filename matching the regex to gitconfig
		[".*/templates/.*.yaml"] = "helm",
		["helmfile.yaml"] = "helm",
		[".*/templates/.*.tpl"] = "helm",
	},
})
