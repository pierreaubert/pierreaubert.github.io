# Spinorama of Alcons Audio RR12 with beamforming examples

[Alcons Audio](https://www.alconsaudio.com/product/rr12/) is a audio company from the Netherlands that focus on professional sound systems.
The RR12 is a point source array module. It can be used vertically or horizontally and is designed to be stacked (as in: you will not use
one of them only). One can do 135dB peak with a dispersion pattern of 30 horizontally and +20/-40 Vertically, -3dB is at 69Hz. The RR12 lunched
in 2013 and still cost around 9k each for a new one. Below is a picture with 4 of them stacked together.

![Alcons Audio RR12](https://pierreaubert.github.io/spinorama/pictures/Alcons%20Audio%20RR12.webp)

Here is the marketing blurb from Alcons Audio:

   > The RR12 is a point-source array element, developed as “building block” to create tight packed arrays for controlled sound coverage in the widest variety of audience areas.
The system features the Alcons-proprietary RBN602rs 6” pro-ribbon driver and a custom-designed 12” woofer with 4” voice coil, dual-spider suspension with forced-venting; while both transducers have Neodymium motor structures, the RR12 has a very high performance-to-weight ratio.
The purpose-designed 6” pro-ribbon driver is based on Alcons’ all-new “RBN02” pro-ribbon platform; This platform dramatically raises the bar in power handling and efficiency of pro-ribbon transducer technology.
The RBN602rs is coupled to an asymmetric “Morph- MaxTM” wave-guide, designed using the latest, state- of-the-art development tools: Proprietary-programmed analysis/simulation software in combination with 3D- prototyping and special manufacturing techniques, resulted in this non-compressing, resonance-free multi-cell guide with wide-band razor-sharp directivity control up to beyond 20kHz..
The trapezoidal cabinet is fitted with integrated mounting hardware, enabling array assembly with just a single operation from the rear of the cabinet.
Tight-packing the RR12 in horizontal or vertical arrays for stacked or flown applications, dispersion patterns are formable in increments of 30°; 30°, 60°, 90°, 120° in the coupling plane, by asymmetric 60° (+20°/-40°) in the non-coupling plane.

## Contents
- [1x RR12](#1x-rr12)
- [3x RR12 in an horizontal array](#3x-rr12-in-an-horizontal-array)
- [6x RR12 in an horizontal array](#6x-rr12-in-an-horizontal-array)
- [Let's add an EQ to the array](#let's-add-an-eq-to-the-array)


## 1x RR12

Let's start with the standard spinorama or CEA2034 graph:
![spinorama](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v1x/CEA2034.webp)
Don't stop to read right now, breath.

That looks horribly bad, a very very bright speaker. If you look closely you will notice that DI is very flat and as a consequence EQ will work well.
Also it is measured at 2m and you are very likely to be at least 10m away or more.

Looking at horizontal and vertical patterns:
![horizontal contour](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v1x/SPL%20Horizontal%20Contour.webp)
![vertical contour](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v1x/SPL%20Vertical%20Contour.webp)
we see that horizontal is around 30 if we are generous and on the vertical plane, it is 20/-40 but only above 1k Hz.

So what can you do with a speaker with this kind of properties: you can stack them vertically or horizontally. 

## 3x RR12 in an horizontal array

The spinorama gets better with still a large deep in the middle.
![spinorama x3](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v3x/CEA2034.webp)

Note that the PIR (predicted in room response) is getting better too:
![pir x3](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v3x/Estimated%20In-Room%20Response.webp)

What is really interesting is the change in the horizontal and vertical contours: you see very clearly what people called beam forming. Remember the very high directionality in the horizontal plane? Now we have a coverage of +/-60.
![horizontal x3](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v3x/SPL%20Horizontal%20Contour.webp)
![horizontal x3](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v3x/SPL%20Vertical%20Contour.webp)

## 6x RR12 in an horizontal array

Let's go wild and put 6 RR12 in an array: the spinorama gets better with still a deep in the middle. On axis, listening window, early reflections and
sound power curves are clustered together.
![spinorama x3](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v6x/CEA2034.webp)

The on axis frequency response is mostly +/3 3dB without EQ:
![onaxis 3x](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v6x/On%20Axis.webp)

The PIR (predicted in room response) is getting better too:
![pir x3](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v6x/Estimated%20In-Room%20Response.webp)

The horizontal and vertical contours shows an increase in coverage with a -100/+100 horizontal pattern:
![horizontal x3](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v6x/SPL%20Horizontal%20Contour.webp)
![horizontal x3](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v6x/SPL%20Vertical%20Contour.webp)

## Let's add an EQ to the array

With a classical IIR parametric EQ, the spinorama becomes excellent:
![spinorama x6 eq](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v6x_eq/CEA2034.webp)

On axis is good:
![onaxis x6 eq](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v6x_eq/On%20Axis.webp)

As is the PIR:
![pir x6 eq](https://pierreaubert.github.io/spinorama/speakers/Alcons%20Audio%20RR12/Alcons%20Audio/vendor-v6x_eq/Estimated%20In-Room%20Response.webp)

Here is the EQ for reference, it will cost you 3dB.
```
EQ for Alcons Audio RR12 computed from Vendors-Alcons Audio data
Preference Score 2.6 with EQ 4.4
Generated from http://github.com/pierreaubert/spinorama/generate_peqs.py v0.16
Dated: 2022-11-12-13:44:53

Preamp: -3.4 dB

Filter  1: ON PK Fc   459 Hz Gain -2.55 dB Q 2.90
Filter  2: ON PK Fc  1246 Hz Gain +2.90 dB Q 0.64
Filter  3: ON PK Fc  4149 Hz Gain +2.56 dB Q 2.28
Filter  4: ON PK Fc 13853 Hz Gain -4.75 dB Q 1.04
Filter  5: ON PK Fc  1288 Hz Gain -1.73 dB Q 2.96
Filter  6: ON PK Fc  2334 Hz Gain +1.43 dB Q 2.81
Filter  7: ON PK Fc   136 Hz Gain -2.03 dB Q 0.61
Filter  8: ON PK Fc   339 Hz Gain +0.88 dB Q 2.95
Filter  9: ON PK Fc  1079 Hz Gain +1.16 dB Q 2.99
```

# Conclusion

A line array allows to tailor the dispersion pattern to the room or the audience while keeping excellent frequency response. And no, they are not for your living room.

They are of course selling the associated amplifiers (4kW and 10kW) with assorted subwoofers that you can also stack to get bass inline with the array.
Alcons Audio has a solid reputation in the touring industry, they are making very good speakers and some studios started to use them which is testimony of the sound
quality.


