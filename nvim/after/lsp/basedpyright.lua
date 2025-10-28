return {
	-- capabilities = {
	-- 	textDocument = {
	-- 		formatting = { dynamicRegistration = false },
	-- 		rangeFormatting = { dynamicRegistration = false },
	-- 	},
	-- },
	settings = {
		-- 1. Basedpyright 고유 설정
		-- basedpyright = {
		-- 	-- ❗️ 임포트 관련 코드 액션 및 분석을 ruff에게 맡깁니다.
		-- 	importStrategy = "ruff",
		-- },

		-- 2. 오리지널 Pyright 설정
		python = {
			-- 타입 검사 수준 (ruff가 하도록 'off'로 꺼도 됨)
			typeCheckingMode = "strict",

			-- 진단 범위 (성능을 위해)
			diagnosticMode = "openFilesOnly",

			analysis = {
				-- 자동완성 시 임포트 제안 활성화
				autoImportCompletions = true,

				-- venv 자동 탐지
				autoSearchPaths = true,
			},
		},
	},
}
