local M = {}

M.file_ignore_patterns = {
    "^.git/",
    -- ".git/",
    "^scratch/",
    -- "%.npz",
    "^.history/",
    "^.cache/",
    "^.idea/",
    "^build/",
    "^devel/",
    "^cmake-build-debug/",
    "**/cmake-build-debug/**",
    "^cmake-build-release/",
    "**/cmake-build-release/**",
}

return M
