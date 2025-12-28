# Git 推送脚本
# 在 PowerShell 中运行此脚本

# 设置编码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# 切换到项目目录
Set-Location "E:\网页开发"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "正在初始化 Git 仓库..." -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
git init
if ($LASTEXITCODE -ne 0) {
    Write-Host "Git 初始化失败，请检查是否安装了 Git" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "正在添加所有文件..." -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "添加文件失败" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "正在提交文件..." -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
git commit -m "Initial commit: 航空器消防救援模拟仿真训练系统"
if ($LASTEXITCODE -ne 0) {
    Write-Host "提交失败，可能没有更改或已提交" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "正在配置远程仓库..." -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
git remote remove origin 2>$null
git remote add origin https://github.com/zts2004/file-preview-system.git
if ($LASTEXITCODE -ne 0) {
    Write-Host "配置远程仓库失败" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "正在重命名分支为 main..." -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
git branch -M main 2>$null

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "正在强制推送到 GitHub..." -ForegroundColor Yellow
Write-Host "注意：这将清空远程仓库的所有内容！" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
git push -f origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "推送失败！可能的原因：" -ForegroundColor Red
    Write-Host "1. 未配置 GitHub 认证（SSH 密钥或 Personal Access Token）" -ForegroundColor Yellow
    Write-Host "2. 网络连接问题" -ForegroundColor Yellow
    Write-Host "3. 仓库不存在或没有权限" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "请检查以上问题后重试" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "完成！项目已成功推送到 GitHub" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "仓库地址: https://github.com/zts2004/file-preview-system" -ForegroundColor Cyan
Write-Host ""

