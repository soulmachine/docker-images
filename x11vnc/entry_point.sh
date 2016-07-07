#!/bin/bash

# 将屏幕分辨率和色彩深度的环境变量组合成
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

# 注册结束信号的捕获器，当容器结束时，尝试让应用程序优雅的关闭
function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}
trap shutdown SIGTERM SIGINT

# 使用Xvfb后台运行指定具有界面的软件，并记录下Xvfb程序的PID
sudo -E -i -u programmer \
  DISPLAY=$DISPLAY \
  xvfb-run --server-args="$DISPLAY -screen 0 $GEOMETRY -ac +extension RANDR" \
  $APP_START &
NODE_PID=$!

# 等待Xvfb程序启动完成
for i in $(seq 1 10); do
  xdpyinfo -display $DISPLAY >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    break
  fi
  echo Waiting xvfb...
  sleep 0.5
done

# 后台运行窗口管理器Fluxbox
fluxbox -display $DISPLAY &

# 后台运行X11vnc服务
x11vnc -forever -usepw -shared -rfbport 5900 -display $DISPLAY &

# 由于所有服务都是后台启动的，最后这个wait确保了在程序结束前，容器不会停止
wait $NODE_PID