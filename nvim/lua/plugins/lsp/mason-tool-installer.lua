return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim", opts = {} },
	opts = {
		ensure_installed = {
			-- Formatters
			"prettier",
			"stylua",
			"taplo",
		},
		-- ["pylsp"] = {
		-- 	-- pylsp가 설치될 때 venv 안에 자동으로 'rope'와 'pylsp-ruff'를 설치합니다.
		-- 	packages = { "rope", "pylsp-ruff" },
		-- 	-- python_binary = "python3" -- venv 생성 시 사용할 파이썬 지정
		-- },
		auto_update = true,
		run_on_start = true,
	},
}
