Simple notebook for plotting speaker data


```python
import numpy as np
import pandas as pd
import plotly as plt
```


```python
from spinorama.load_spl_hv_txt import parse_graph_spl_hv_txt
from spinorama.load import filter_graphs
```


```python
# dir = 'where your files are'
# the parser expect to find the 72 files in this directory
# name of the file is *_H angle.txt for horizontal measurements with angle between -170 and 180 in 10 degrees increment
# name of the file is *_V angle.txt for vertical measurements with angle between -170 and 180 in 10 degrees increment
speaker = 'Ascend Acoustics Sierra-2EX V2'
dir = f'../datas/measurements/{speaker}/vendor'

# read horizontal and vertical data
# spl_H and spl_V are dataframe
_, spl_H = parse_graph_spl_hv_txt(dir, 'H')
_, spl_V = parse_graph_spl_hv_txt(dir, 'V')

# put them in a convenient dictionnary of dataframe
df = filter_graphs(speaker, spl_H, spl_V)
```


```python
from spinorama.compute_cea2034 import compute_cea2034
```


```python
# compute the spin
spin = compute_cea2034(df['SPL Horizontal_unmelted'], df['SPL Vertical_unmelted'])
```


```python
import spinorama.plot as plot

# example of the parameters you can change for the layout
# see plotly documentation for all the options
my_layout = dict(
    width=1000,
    height=600,
    title=dict(
        x=0.5,
        y=1.0,
        xanchor="center",
        yanchor="top",
        text=speaker, 
        font=dict(
            size=20,
        ),
    ), 
    legend=dict(
        x=1.2, 
        y=1, 
        xanchor="center", 
        orientation="v",
        font=dict(
            size=12,
        ),
    ),
    font=dict(
        size=14
    ),
)
```


```python
plot_spin = plot.plot_spinorama(spin, plot.plot_params_default)
plot_spin.update_layout(my_layout)
plot_spin
```

```python
plot_contour_h = plot.plot_contour(df['SPL Horizontal_unmelted'], plot.contour_params_default)
plot_contour_h.update_layout(my_layout)
plot_contour_h
```
