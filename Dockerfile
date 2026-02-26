FROM tensorflow/tensorflow:2.17.0-gpu


# タイムゾーンの設定（対話プロンプトが出ないように設定）
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 最小限のシステムパッケージ（git, wget を追加）
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    wget \
    libglib2.0-0 \
    libgl1-mesa-glx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# pipのアップグレード
RUN pip install --no-cache-dir --upgrade pip

# 研究室用パッケージと requirements.txt のインストール
# (requirements.txt 内に torch 等が書かれている場合は、ベースイメージと競合しないよう注意してください)
COPY requirements.txt .
RUN pip install --no-cache-dir praat-parselmouth
RUN pip install --no-cache-dir -r requirements.txt
~
