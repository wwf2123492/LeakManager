# LeakManager
检查ViewController的泄露，如果一个viewController被pop或dissmiss后还没有被析构，会自动报错提示
检查viewcontroller的内存泄露问题，思路很简单，大家可以自己代码

使用很简单，如下即可：

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [LeakManager viewControllerWillDisAppear:self];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [LeakManager viewControllerDidDisAppear:self];
}