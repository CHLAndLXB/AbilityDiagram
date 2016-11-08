//
//  ViewController.m
//  AbilityDiagram
//
//  Created by huochaihy on 2016/11/8.
//  Copyright © 2016年 CHLdemo.com. All rights reserved.
//

#import "ViewController.h"

#define UIColorHex(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    NSDictionary * dic = @{@"输出":@"22.8",@"综合":@"44.8",@"KDA":@"44.2",@"发育":@"43.3",@"推进":@"90.7",@"生存":@"73.5"};
    
    
    /*---------------------------------*/
    UIImage * image = [self ValueImageWithDic:dic];
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    [imageView setImage:image];
    [view addSubview:imageView];
    
    UILabel * label1 = [self createLabelWithFrame:CGRectMake(CGRectGetMinX(imageView.frame)-5-40, CGRectGetMinY(imageView.frame)+37-10, 40, 40)];
    label1.text = @"输出 22.8";
    [view addSubview:label1];
    
    UILabel * label2 = [self createLabelWithFrame:CGRectMake(CGRectGetMinX(imageView.frame) + 5 - 20, CGRectGetMinY(imageView.frame)-5-30, 40, 40)];
    label2.text = @"综合 44.8";
    [view addSubview:label2];
    
    UILabel * label3 = [self createLabelWithFrame:CGRectMake(CGRectGetMaxX(label2.frame) + 53.5-10-5, CGRectGetMinY(imageView.frame)-5-30, 40, 40)];
    label3.text = @"KDA 44.2";
    [view addSubview:label3];
    
    UILabel * label4 = [self createLabelWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinY(label1.frame), 40, 40)];
    label4.textAlignment = NSTextAlignmentLeft;
    label4.text = @"发育 43.3";
    [view addSubview:label4];
    
    UILabel * label5 = [self createLabelWithFrame:CGRectMake(CGRectGetMinX(label3.frame), CGRectGetMaxY(label1.frame) + 37 - 20, 40, 40)];
    label5.text = @"推进 90.7";
    [view addSubview:label5];
    
    UILabel * label6 = [self createLabelWithFrame:CGRectMake(CGRectGetMinX(label2.frame), CGRectGetMinY(label5.frame), 40, 40)];
    label6.text = @"生存 73.5";
    [view addSubview:label6];
}

-(UILabel *)createLabelWithFrame:(CGRect )rect{
    UILabel * label1 = [[UILabel alloc]initWithFrame:rect];
    //label1.backgroundColor = [UIColor yellowColor];
    label1.textAlignment = NSTextAlignmentRight;
    label1.textColor = UIColorHex(0xffffff, 1.0);
    label1.font = [UIFont systemFontOfSize:10];
    label1.numberOfLines = 2;
    
    return label1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)ValueImageWithDic:(NSDictionary *)dic{
    UIImage * image = [UIImage imageNamed:@"nenglitu"];
    
    CGPoint point = CGPointMake(image.size.width/2, image.size.height/2);
    CGFloat shuchuValue = [dic[@"输出"] floatValue];
    CGFloat zongheValue = [dic[@"综合"] floatValue];
    CGFloat KDAValue = [dic[@"KDA"] floatValue];
    CGFloat fayuValue = [dic[@"发育"] floatValue];
    CGFloat tuijinValue = [dic[@"推进"] floatValue];
    CGFloat shengcunValue = [dic[@"生存"] floatValue];
    
    CGFloat width = image.size.width/2;
    
    CGSize size=CGSizeMake(image.size.width, image.size.height);//画布大小
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    [image drawAtPoint:CGPointMake(0,0)];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, UIColorHex(0x1b29b4,0.5).CGColor);
    
    CGContextSetStrokeColorWithColor(ctx, UIColorHex(0x2b38bc,1).CGColor);
    
    CGMutablePathRef path1=CGPathCreateMutable();
    
    CGPathMoveToPoint(path1, nil, point.x-width*shuchuValue/100.0, point.y);//移动到指定位置（设置路径起点）
    CGPathAddLineToPoint(path1, nil, point.x - width*zongheValue/100.0/2, point.y - width*zongheValue/100.0*sqrt(3)/2);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path1, nil, point.x+width*KDAValue/100.0/2,point.y - width*KDAValue/100.0*sqrt(3)/2);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path1, nil, point.x + width*fayuValue/100.0, point.y);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path1, nil, point.x + width*tuijinValue/100.0/2,point.y + width*tuijinValue/100.0*sqrt(3)/2);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path1, nil, point.x - width*shengcunValue/100.0/2,point.y + width*shengcunValue/100.0*sqrt(3)/2);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path1, nil, point.x-width*shuchuValue/100.0,point.y);//绘制直线（从起始位置开始）
    
    //2.b.3把圆的路径添加到图形上下文中
    CGContextAddPath(ctx, path1);
    
    //CGContextStrokePath(ctx);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //6.释放对象
    CGPathRelease(path1);
    
    return im;
}



@end
