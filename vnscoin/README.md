This docker image wraps vnsRelease as a single executable.


## Build the image

    cd vnscoin
    docker build -t soulmachine/vnscoin .


## How to use it

    # Start to mine
    docker run -d soulmachine/vnscoin d9fe419028e25adb407208719e0d0aaef92898d4
