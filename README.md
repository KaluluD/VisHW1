# VisHW1
### Lujia

#### I. Sketches and Storyboards

##### Static Vis & Reordering axises

![Alt text](/images/1.jpg)

##### Axis reordering

![Alt text](/images/2.jpg)


#### II. Implementation Screenshots

##### Basic visualization for the car dataset and the camera dataset

![Alt text](/images/CameraData.PNG)

![Alt text](/images/CarData.PNG)

##### Interaction: axis reordering

###### Select the first column “cylinders”. The column is highlighted.

![Alt text](/images/Reorder1.PNG)

###### Select the second column “mpg”. The two columns swap positions.

![Alt text](/images/Reorder2.PNG)

#### III. Discussion of Design Choices
The static view is just a basic parallel coordinates design. The lines are designed to be transparent in order to address the “hairball” problem. For the axis reordering, two columns are selected and automatically switch positions. Frankly speaking, this design is for implementation simplicity. A much better way to reorder axises is to select and drag an axis to a desirable position, and the rest axises would shift either right or left to fill empty positions. Besides, I was not able to successfully implement the filtering interaction feature. I would like to discuss the design conceptually. The idea is to use the mouse to draw a filter box along an axis and only the rows within the filter box would be displayed ordinarily; others would be displayed using a transparent gray color.

#### IV. Future Improvement 
Interactive design choice I want to add to the current design is that when the mouse moves to a single line, the line will be highlighted and a box of all the relevant data information will be displayed. 
Multiple views are useful to support the data exploration. For example, adding a histogram when an integer/float attribute is selected, which shows the distribution of the number of items falling into different levels of this attribute.
