
#  Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
#  Licensed under the Apache License, Version 2.0 (the "License").
#  You may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

#!/usr/bin/bash

# 
# Train MQM baseline on top of DA
# 

# use "fake" dev data to skip validation inference because we train for one epoch in any case
head -n 10 "${ADAPTATION_ROOT}/data/mqm/general/train/all.csv" > "${ADAPTATION_ROOT}/data/mqm/general/test/micro_fake.csv"

nohup comet-train \
    --load_from_checkpoint ${ADAPTATION_ROOT}/models/trained/da/main/checkpoints/epoch=0-*.ckpt \
    --cfg metrics_domain_adaptation/configs/comet_mqm_1ep/main.yaml \
    --model-checkpoint-dirpath "${ADAPTATION_ROOT}/models/trained/mqm/main/checkpoints" \
    --train-data "${ADAPTATION_ROOT}/data/mqm/general/train/all.csv" \
    --validation-data "${ADAPTATION_ROOT}/data/mqm/general/test/micro_fake.csv" \
> logs/train_main_mqm.log &

