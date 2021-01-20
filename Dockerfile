FROM alpine:latest

# install chrony
RUN apk add --no-cache chrony

# script to configure/startup chrony (ntp)
COPY assets/startup.sh /opt/startup.sh

# ntp port
EXPOSE 123/udp

# let docker know how to test container health
HEALTHCHECK CMD chronyc tracking || exit 1

# start chronyd in the foreground
ENTRYPOINT [ "/bin/sh", "/opt/startup.sh" ]

#docker build -t land007/ntp:latest .
#> docker buildx build --platform linux/amd64,linux/arm64/v8,linux/arm/v7 -t land007/ntp --push .
#docker run --name=ntp --restart=always --detach --publish=123:123/udp --cap-add=SYS_TIME --read-only --tmpfs=/etc/chrony:rw,mode=1750 --tmpfs=/run/chrony:rw,mode=1750 --tmpfs=/var/lib/chrony:rw,mode=1750 land007/ntp:latest

#sudo apt-get install ntpdate
#ntpdate -q jiayiqiu.vicp.net
# server 111.201.69.7, stratum 3, offset 1.477483, delay 0.03462
# 20 Jan 14:53:06 ntpdate[611]: step time server 111.201.69.7 offset 1.477483 sec

#sudo apt install chrony
#vi /etc/chrony.conf
#systemctl start chronyd.service
#chronyc sources
# MS Name/IP address         Stratum Poll Reach LastRx Last sample
# ===============================================================================
# ^* 203.107.6.88                  2   6   377    26   -703ms[-1479ms] +/-   21ms

#docker exec ntp-server chronyc tracking
# Reference ID    : CB6B0658 (203.107.6.88)
# Stratum         : 3
# Ref time (UTC)  : Wed Jan 20 06:48:29 2021
# System time     : 0.000983638 seconds fast of NTP time
# Last offset     : -1.239670753 seconds
# RMS offset      : 1.343616009 seconds
# Frequency       : 22902.383 ppm slow
# Residual freq   : -10058.454 ppm
# Skew            : 810.996 ppm
# Root delay      : 0.036821567 seconds
# Root dispersion : 0.550662100 seconds
# Update interval : 64.4 seconds
# Leap status     : Normal

#docker exec ntp-server chronyc sources
# MS Name/IP address         Stratum Poll Reach LastRx Last sample
# ===============================================================================
# ^* 203.107.6.88                  2   6   377    26   -703ms[-1479ms] +/-   21ms

#docker exec ntp-server chronyc sourcestats
# Name/IP Address            NP  NR  Span  Frequency  Freq Skew  Offset  Std Dev
# ==============================================================================
# 203.107.6.88                9   5   511 -13405.891   5445.682   -359ms   482ms
