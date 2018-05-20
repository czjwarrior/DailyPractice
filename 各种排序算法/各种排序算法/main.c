//
//  main.c
//  各种排序算法
//
//  Created by 岑志军 on 2018/5/19.
//  Copyright © 2018年 岑志军. All rights reserved.
//

#include <stdio.h>


#pragma mark - 冒泡排序
void buddingSort(int *arr, int n){
    
    int i, j;
    for (i = 0; i < n; i++) {
        int flag = 0;
        for (j = n-1; j>=i; j--) {
            
            if (arr[j-1] > arr[j]) {
                int temp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = temp;
                flag = 1;
            }
        }
        if (flag == 0) {
            break;
        }
    }
}

int main(int argc, const char * argv[]) {
    // insert code here...
    
    int arr[] = {4, 3, 9, 2, 1, 7, 12, 15, 19, 16};
    
    buddingSort(arr, 10);
    
    for (int i=0; i<10; i++) {
        printf("%d\n", arr[i]);
    }
    return 0;
}
