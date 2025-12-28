# 修复 Cursor 终端环境的脚本
# 这个脚本会设置正确的编码和执行策略

# 设置控制台编码为 UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

# 设置执行策略（如果需要）
try {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force -ErrorAction SilentlyContinue
} catch {
    Write-Host "执行策略设置失败，但可以继续" -ForegroundColor Yellow
}

Write-Host "终端环境已修复！" -ForegroundColor Green
Write-Host "编码: UTF-8" -ForegroundColor Cyan
Write-Host "执行策略: RemoteSigned (Process)" -ForegroundColor Cyan


