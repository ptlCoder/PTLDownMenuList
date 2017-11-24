# PTLDownMenuList
下拉列表
###简单用发
```
PTLMenuButton *btn = [[PTLMenuButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) menuTitles:@[@"科室",@"排序"]];
    NSArray * listArr1 = @[@"全科",@"妇产科",@"儿科",@"内科",@"外科",@"中医科",@"口腔科",@"耳科",@"耳鼻喉科"];
    NSArray * listArr2 = @[@"综合排序",@"评分",@"问诊量",@"价格"];
    btn.listTitles = @[listArr1, listArr2];
    btn.delegate = self;
    [self.view addSubview:btn];
```
###遵循PTLMenuButtonDelegate代理协议
```
-(void)ptl_menuButton:(PTLMenuButton *)menuButton didSelectMenuButtonAtIndex:(NSInteger)index selectMenuButtonTitle:(NSString *)title listRow:(NSInteger)row rowTitle:(NSString *)rowTitle{
    NSLog(@"index: %zd, title:%@, listrow: %zd, rowTitle: %@", index, title, row, rowTitle);
}
```

-----------------------------------------------------------------------------------------
# KMTagListView
tag标签
###简单用发
```
KMTagListView *tag = [[KMTagListView alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width, 0)];
    tag.delegate_ = self;
    [tag setupSubViewsWithTitles:@[@"哈哈哈哈哈哈", @"哈试发",@"哈你发",@"哈哈试会计给你发",@"哈哈你发",@"哈哈哈哈哈发", @"哈哈哈哈哈哈考试会计给你发",@"哈哈哈哈哈发",@"哈哈发",@"哈哈哈哈哈发",@"哈哈计给你发",@"哈哈哈哈哈发",@"哈哈哈发",@"哈哈哈哈哈发",@"哈哈你发",@"哈发"]];
    [self.view addSubview:tag];

    CGRect rect = tag.frame;
    rect.size.height = tag.contentSize.height;
    tag.frame = rect;
```
###遵循PTLMenuButtonDelegate代理协议
```
-(void)ptl_TagListView:(KMTagListView *)tagListView didSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content {
    NSLog(@"content: %@ index: %zd", content, index);
    
}
```
