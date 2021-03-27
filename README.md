This fork serves as a sample on how to receive Bitmap image from graph for additional postprocessing (https://github.com/google/mediapipe/issues/831).
It works with android example app https://github.com/Cubbee/mediapipe_multi_hands_tracking_aar_example

1. From the mediapipe side, you need to add GpuBufferToImageFrameCalculator to the graph somewhere, for example `mediapipe/graphs/hand_tracking/hand_tracking_mobile.pbtxt`

```
node {
   calculator: "GpuBufferToImageFrameCalculator"
   input_stream: "throttled_input_video"
   output_stream: "throttled_input_video_cpu"
 }
```

2. Add this calculator to needed graph BUILD file `mediapipe/graphs/hand_tracking/BUILD`
```
cc_library(
    name = "mobile_calculators",
    deps = [
        "//mediapipe/calculators/core:constant_side_packet_calculator",
        "//mediapipe/calculators/core:flow_limiter_calculator",
        "//mediapipe/graphs/hand_tracking/subgraphs:hand_renderer_gpu",
        "//mediapipe/modules/hand_landmark:hand_landmark_tracking_gpu",
        "//mediapipe/gpu:gpu_buffer_to_image_frame_calculator",
    ],
)
```
3. Listen to the packet and decode it to bitmap
```
processor.addPacketCallback(
    "transformed_image_cpu"
) { packet ->
    println("Received image with ts: ${packet.timestamp}")
    val image = AndroidPacketGetter.getBitmapFromRgba(packet)
}
```

# How to build

1. Clone this repo

2. `git checkout 0.8.2-bitmap-sample`

3. Build and run docker image
   ` ./run_docker.sh`

4. Build aar and graph inside docker
`./build_aar.sh`

    It will create `hand_tracking_mobile_gpu.binarypb` and `mp_multi_hand_aar.aar` at the repo root folder

4. You need to copy `mp_multi_hand_aar.aar` to `app/libs`
and `hand_tracking_mobile_gpu.binarypb` to `app/src/main/assets`
