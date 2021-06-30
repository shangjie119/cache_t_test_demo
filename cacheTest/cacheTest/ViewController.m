//
//  ViewController.m
//  cacheTest
//
//  Created by sj on 2021/6/29.
//

#import "ViewController.h"

#import "SJPerson.h"

#ifdef DEBUG
#define SJLog(format, ...) printf("%s\n", [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define SJLog(format, ...);
#endif


struct SJ_Bucket
{
    IMP _imp;
    SEL _sel;
};

struct SJ_Cache {
    uintptr_t _bucketsAndMaybeMask;
    uint32_t _maybeMask;
    uint16_t _flags;
    uint16_t _occupied;
};

struct SJ_Class {
    Class isa;
    Class superClass;
    struct SJ_Cache cache;
    uintptr_t bits;
};

@interface ViewController ()

@property (nonatomic, strong) NSMutableString *text;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view..
    
    self.text = [NSMutableString string];
    
    SJPerson *p = [SJPerson alloc];
    Class pClass = [SJPerson class];
    struct SJ_Class *sj_class = (__bridge struct SJ_Class *)pClass;
    
    [p say1];
    [self logCacheInfo:sj_class];
    
    [p say2];
    [self logCacheInfo:sj_class];
    
    [p say3];
    [self logCacheInfo:sj_class];
    
    [p say4];
    [self logCacheInfo:sj_class];
    
    [p say5];
    [self logCacheInfo:sj_class];
    
    [p say6];
    [self logCacheInfo:sj_class];
    
    [p say7];
    [self logCacheInfo:sj_class];
    
    [p say8];
    [self logCacheInfo:sj_class];
    
    [p say9];
    [self logCacheInfo:sj_class];
    
    [p say10];
    [self logCacheInfo:sj_class];
    
    [p say11];
    [self logCacheInfo:sj_class];
    
    [p say12];
    [self logCacheInfo:sj_class];
    
    [p say13];
    [self logCacheInfo:sj_class];
    
    [p say14];
    [self logCacheInfo:sj_class];
    
    [p say15];
    [self logCacheInfo:sj_class];
    
    [p say16];
    [self logCacheInfo:sj_class];
    
    [p say17];
    [self logCacheInfo:sj_class];
    
    [p say18];
    [self logCacheInfo:sj_class];
    
    [p say19];
    [self logCacheInfo:sj_class];
    
    [p say20];
    [self logCacheInfo:sj_class];
    
    [p say21];
    [self logCacheInfo:sj_class];
    
    [p say22];
    [self logCacheInfo:sj_class];
    
    [p say23];
    [self logCacheInfo:sj_class];
    
    [p say24];
    [self logCacheInfo:sj_class];
    
    [p say25];
    [self logCacheInfo:sj_class];
    
    [p say26];
    [self logCacheInfo:sj_class];
    
    [p say27];
    [self logCacheInfo:sj_class];
    
    [p say28];
    [self logCacheInfo:sj_class];
    
    [p say29];
    [self logCacheInfo:sj_class];
    
    [p say30];
    [self logCacheInfo:sj_class];
    
    [p say31];
    [self logCacheInfo:sj_class];
    
    [p say32];
    [self logCacheInfo:sj_class];
    
    [p say33];
    [self logCacheInfo:sj_class];
    
    [p say34];
    [self logCacheInfo:sj_class];
    
    [p say35];
    [self logCacheInfo:sj_class];
    
    [p say36];
    [self logCacheInfo:sj_class];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 80, 300, 500)];
    [self.view addSubview:textView];
    textView.text = self.text;
}

- (void)logCacheInfo:(struct SJ_Class *)sj_class
{
    SJLog(@"_maybeMask : %u   _flags : %u   _occupied : %u", sj_class->cache._maybeMask, sj_class->cache._flags, sj_class->cache._occupied);
    NSLog(@"buckets 地址 ：%lu", sj_class->cache._bucketsAndMaybeMask);
    
    [self.text appendString:[NSString stringWithFormat:@"_maybeMask : %u   _flags : %u   _occupied : %u", sj_class->cache._maybeMask, sj_class->cache._flags, sj_class->cache._occupied]];
    [self.text appendString:@"\n"];
    [self.text appendString:[NSString stringWithFormat:@"buckets 地址 ：%lu", sj_class->cache._bucketsAndMaybeMask]];
    [self.text appendString:@"\n"];
    
    uintptr_t mask = sj_class->cache._bucketsAndMaybeMask >> 48;
    NSLog(@"mask : %lu", mask);
    [self.text appendFormat:@"mask : %lu", mask];
    [self.text appendString:@"\n"];
    
    struct SJ_Bucket *buckets = (struct SJ_Bucket *)(sj_class->cache._bucketsAndMaybeMask << 16 >> 16);
    int newMask = (int)mask;
    for (int i = 0; i <= newMask; i++) {
        struct SJ_Bucket bucket = buckets[i];
        SJLog(@"sel : %@  imp : %p", NSStringFromSelector(bucket._sel), bucket._imp);
        [self.text appendFormat:@"sel : %@  imp : %p", NSStringFromSelector(bucket._sel), bucket._imp];
        [self.text appendString:@"\n"];
    }
    
//    for (int i = 0; i < sj_class->cache._maybeMask; i++) {
//        struct SJ_Bucket bucket = sj_class->cache.buckets[i];
//        SJLog(@"sel : %@  imp : %p", NSStringFromSelector(bucket._sel), bucket._imp);
//    }
    SJLog(@"========================");
    [self.text appendString:@"=================="];
    [self.text appendString:@"\n"];
}

@end
