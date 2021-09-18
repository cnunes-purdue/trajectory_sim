import numpy as np
from mayavi import mlab


def import_data():
    print("test")
    # data_x = np.loadtxt(open("x.csv", "rb"), delimiter=",")
    # data_x = data_x.reshape([81, 81, 81])
    # data_y = np.loadtxt(open("y.csv", "rb"), delimiter=",")
    # data_y = data_y.reshape([81, 81, 81])
    # data_z = np.loadtxt(open("z.csv", "rb"), delimiter=",")
    # data_z = data_z.reshape([81, 81, 81])
    data_w = np.loadtxt(open("w.csv", "rb"), delimiter=",")
    data_w = data_w.reshape([81, 81, 81])
    return data_w


def explore3d(data_cube):
    source = mlab.pipeline.scalar_field(data_cube)
    source.spacing = [1, 1, -1]

    nx, ny, nz = data_cube.shape
    mlab.pipeline.image_plane_widget(source, plane_orientation='x_axes',
                                     slice_index=nx // 2, colormap='jet')
    mlab.pipeline.image_plane_widget(source, plane_orientation='y_axes',
                                     slice_index=ny // 2, colormap='jet')
    mlab.pipeline.image_plane_widget(source, plane_orientation='z_axes',
                                     slice_index=nz // 2, colormap='jet')
    mlab.show()


if __name__ == '__main__':
    data_w = import_data()
    explore3d(data_w)
