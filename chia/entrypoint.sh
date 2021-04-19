cd /chia-blockchain

. ./activate

chia init

start_time="$(date -u +%s)"

exec "$@"

end_time="$(date -u +%s)"

elapsed="$(($end_time-$start_time))"
echo "Time elapsed $elapsed seconds"
