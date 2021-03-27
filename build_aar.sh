# Build aar
bazel build -c opt --host_crosstool_top=@bazel_tools//tools/cpp:toolchain --fat_apk_cpu=arm64-v8a,armeabi-v7a \
    //mediapipe/examples/android/src/java/com/google/mediapipe/apps/aar_example:mp_multi_hand_aar \
    && rm -f ./mp_multi_hand_aar.aar \
    && cp bazel-bin/mediapipe/examples/android/src/java/com/google/mediapipe/apps/aar_example/mp_multi_hand_aar.aar .

# Build graph
bazel build -c opt //mediapipe/graphs/hand_tracking:hand_tracking_mobile_gpu_binary_graph \
    && rm -f ./hand_tracking_mobile_gpu.binarypb \
    && cp bazel-bin/mediapipe/graphs/hand_tracking/hand_tracking_mobile_gpu.binarypb .