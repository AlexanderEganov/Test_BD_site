#include <opencv2/opencv.hpp>
#include <iostream>
#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <stdlib.h>
#include <stdio.h>
using namespace std;
using namespace cv;
int main()
{
//Однородное сглаживание (Фильтр-размытие-среднее)

namedWindow("Before", CV_WINDOW_AUTOSIZE);

Mat one = imread("airport_Brazil.jpg", 1);

Mat neew; //будет конечным изображением

imshow("Before", one);

//for (int i = 1; i<12; i = i + 2)

int i = 3;

blur(one, neew, Size(i, i)); /*сглаживаем изображение в «src» и сохраняем его в «dst»*/

imshow("Smoothing by avaraging", neew);

//Контрастная ограниченная адаптивная гистограмма

// преобразовываем в Lab

Mat bgr_image = imread("Indira_Gandhi_airport.jpg");

Mat lab_image;

cvtColor(bgr_image, lab_image, CV_BGR2Lab);

// Извлекаем канал L

std::vector<Mat> lab_planes(3);

split(lab_image, lab_planes); // теперь у нас есть L - образ в lab_planes[0]

//алгоритм повышения контраста

Ptr<CLAHE> clahe = createCLAHE();

clahe->setClipLimit(4);

Mat dst;

clahe->apply(lab_planes[0], dst);

dst.copyTo(lab_planes[0]);

merge(lab_planes, lab_image); //соединяет

//конвертировать обратно в RGB

Mat image_clahe;

cvtColor(lab_image, image_clahe, CV_Lab2BGR);

// отобразить результаты(вы также можете увидеть lab_planes[0] до и после).

imshow("image original", bgr_image);

imshow("image CLAHE", image_clahe);

//Детектор Собеля

Mat src, src_gray;

Mat grad;

namedWindow("Befor", CV_WINDOW_AUTOSIZE);

int scale = 1; //опциональный параметр, который задает коэффициент масштабирования для вычисляемых значений производных

int delta = 0; //опциональный параметр смещения интенсивности

int ddepth = CV_16S; //глубина результирующего изображения.

int c;

src = imread("airport_Riga.jpg", CV_LOAD_IMAGE_COLOR);

if (!src.data)

{

return -1;

}

cvtColor(src, src_gray, CV_BGR2GRAY);

namedWindow("Display window", CV_WINDOW_AUTOSIZE);

/// Генерировать grad_x и grad_y

Mat grad_x, grad_y;

Mat abs_grad_x, abs_grad_y;

/// Gradient X

Sobel(src_gray, grad_x, ddepth, 1, 0, 3, scale, delta, BORDER_DEFAULT);

convertScaleAbs(grad_x, abs_grad_x); //преобразование градиентов в 8-битные

/// Градиент Y

Sobel(src_gray, grad_y, ddepth, 0, 1, 3, scale, delta, BORDER_DEFAULT);

convertScaleAbs(grad_y, abs_grad_y);

/// Общий градиент (приблизительный)

addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0, grad);

imshow("Display window", grad);

imshow("Befor", src);

waitKey(0);

return 0;

}
