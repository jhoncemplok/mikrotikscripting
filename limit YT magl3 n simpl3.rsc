/ip firewall layer7-protocol
add name=youtube regexp="r[0-9]+---[a-z]+-+[a-z0-9-]+\\.googlevideo\\.com"

/ip firewall mangle
add action=mark-connection chain=prerouting layer7-protocol=youtube new-connection-mark=yt_vid_conn src-address=192.168.2.2
add action=mark-packet chain=prerouting connection-mark=yt_vid_conn new-packet-mark=yt_vi_pkt passthrough=no

/queue simple
add max-limit=128k/256k name=Youtube packet-marks=yt_vi_pkt target=192.168.2.2/32

