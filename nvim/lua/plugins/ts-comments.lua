-- mini.comment는 파일타입 또는 treesitter가 인식한 언어에
-- 의해 결정되는 `commentstring`을 이용한다
-- `vue`파일의 `<template>`부분은 `vue`언어로 인식되는데,
-- `vue`에 할당된 `commentstring`이 존재하지 않는다
-- 이 플러그인은 언어에 따른 `commentstring`을 설정해준다
return {
	"folke/ts-comments.nvim",
	opts = {},
	event = "VeryLazy",
}
