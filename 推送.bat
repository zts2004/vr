@echo off
chcp 65001 >nul
echo ========================================
echo 正在初始化 Git 仓库...
echo ========================================
git init

echo.
echo ========================================
echo 正在添加所有文件...
echo ========================================
git add .

echo.
echo ========================================
echo 正在提交文件...
echo ========================================
git commit -m "Initial commit: 航空器消防救援模拟仿真训练系统"

echo.
echo ========================================
echo 正在配置远程仓库...
echo ========================================
git remote remove origin 2>nul
git remote add origin https://github.com/zts2004/file-preview-system.git

echo.
echo ========================================
echo 正在重命名分支为 main...
echo ========================================
git branch -M main 2>nul

echo.
echo ========================================
echo 正在强制推送到 GitHub...
echo 注意：这将清空远程仓库的所有内容！
echo ========================================
echo.
git push -f origin main

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo 完成！项目已成功推送到 GitHub
    echo ========================================
    echo 仓库地址: https://github.com/zts2004/file-preview-system
) else (
    echo.
    echo ========================================
    echo 推送失败！
    echo ========================================
    echo 可能的原因：
    echo 1. 未配置 GitHub 认证
    echo 2. 网络连接问题
    echo 3. 仓库不存在或没有权限
    echo.
    echo 请检查后重试
)

echo.
pause

