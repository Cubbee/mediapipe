docker build . -t mediapipe
docker run --rm  --network host --ipc=host -v $(pwd):/home/mediapipe -w /home/mediapipe -it mediapipe /bin/bash
