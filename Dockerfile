FROM fedora:38 

WORKDIR /opt/workdir

# Disable weak dependencies to reduce image size.
RUN echo "install_weak_deps=False" >> /etc/dnf/dnf.conf 
RUN dnf install -y \
    clang \
    cmake \
    ninja-build \
    vulkan-devel \
    vulkan-headers

# Build and install into a directory with CMake.
CMD cmake \
    -B target/release \
    -D CMAKE_BUILD_TYPE=Release \
    -G 'Ninja' && \
    cmake --build target/release -j$(nproc) && \
    DESTDIR="/opt/installdir" cmake --build target/release --target=install