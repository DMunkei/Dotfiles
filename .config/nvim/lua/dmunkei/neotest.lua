require("neotest").setup({
    adapters = {
        require("neotest-python"), require('neotest-go'),
        require('neotest-jest'), require('neotest-rust')
    }
})
