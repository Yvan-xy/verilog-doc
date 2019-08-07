# verilog 文档整理  
---

## 入门  

#### - 如何开始  

&emsp;&emsp;欢迎来到二进制的世界,数字逻辑的入门一开始可能有难度,因为你需要学习新的概念,新的硬件描述语言(HDL -- Hardware Description Language)例如 `verilog`,几个新的仿真软件和一块FPGA的板子.但是这能帮你更加深刻的理解计算机的运作原理.  

&emsp;&emsp;设计电路需要如下几个步骤:  

1. 编写HDL(verilog)代码  
2. 编译代码生成电路  
3. 模拟电路并修复错误  

&emsp;&emsp;下面,我们来个简单的例子,请把`one`的输出设为1:  

- Module Declaration
```verilog
module top_module(output one);
```

- Solution
```
module top_module( output one );

    assign one = 1;

endmodule
```


#### - 输出0

&emsp;&emsp;建立一个没有输入,输出为常数0的电路.

&emsp;&emsp;本系列题使用***verilog-2001 ANSI-style*** 的端口声明语法，因为它更容易阅读并减少了拼写错误。如果愿意，可以使用旧的verilog-1995语法。例如，下面的两个模块声明是可接受的和等效的:  

```verilog
module top_moduel(zero);
	output zero;
	//verilog-1995
endmodule

module top_module(output zero);
//verilog-2001
endmodule
```

- Module Declaration
```verilog
module top_module(
    output zero
);
```

- Solution
```verilog
module top_module(
    output zero
);// Module body starts after semicolon
	assign zero=0;
endmodule
```

---

## Verilog 语言  

### 基础元素  

#### - wire类型  

&emsp;&emsp;创建一个具有一个输入和一个输出的模块,其行为想一条"线"(Wire).  

&emsp;&emsp;与物理线不同但十分相似,Verilog中的线(和其他信号)是定向的。这意味着信息只在一个方向上流动,从(通常是一个)源流向汇点(该源通常也被称为驱动程序，将值驱动到wire上).在verilog"连续赋值"(assign left_side=right_side;)中，右侧的信号值被驱动到左侧的"线"上.请注意:赋值是"***连续的***"(Continuous Assignments),因为如果右侧的值发生更改,分配也会一直持续,因此左侧的值将随之改变.(这里与其他语言有很大区别).连续分配不是一次性事件,其产生的变化是永久的.

> 想要真正理解为啥会这样,你首先要明白,你并不是在编写程序,你其实是在用代码"画"电路!
> 因此输入端的电平高低的变化必然会影响到wire的另一端,你可以想像真的有一根电线连接两个变量.

&emsp;&emsp;模块(module)上的端口(port)也有一个方向(通常是输入 -- input或输出 -- output)。输入端口由来自模块外部的东西驱动，而输出端口驱动外部的东西。从模块内部查看时，输入端口是驱动程序或源，而输出端口是接收器。

&emsp;&emsp;下图说明了电路的每个部分如何对应Verilog代码的每个部分.模块和端口声明创建电路的黑色部分。您的任务是通过添加一个assign语句来创建一条线(绿色).盒子外的部件不是您的问题，但您应该知道,通过将测试激励连接到top_module上的端口来测试电路。

![sp_wire](./picture/sp_wire.png)  

> 除了连续赋值之外，Verilog还有另外三种用于程序块(Procedural block)的赋值类型,其中两种是可综合的.在开始使用Procedural block之前，我们不会使用它们。

- Module Declaraction
```verilog
module top_module( input in, output out );
```

- Solution
```verilog
module top_module( input in, output out );
    assign out = in;
endmodule
```

#### - Four wires  

&emsp;&emsp;创建一个具有3个输入和4个输出的模块,这些输入和输出的行为如下:
```
A ->W
B -> X
B -> Y
C -> Z
```
&emsp;&emsp;下图说明了电路的每个部分如何对应Verilog代码的每个部分.模块外部有三个输入端口和四个输出端口.  

&emsp;&emsp;当您有多个assign语句时,它们在代码中的出现顺序并不重要.与编程语言不同,assign语句("连续赋值")描述事物之间的连接,而不是将值从一个事物复制到另一个事物的操作.  

&emsp;&emsp;可能现在应该澄清的一个潜在的困惑来源是:这里的绿色箭头表示电线之间的连接,但不是wire本身.模块本身已经声明了7条线(名为A、B、C、W、X、Y和Z).这是因为input与output被声明为了wire类型.因此,assign语句不会创建wire,而是描述了在已存在的7条线之间创建的连接.

![wire4](./picture/wire4.png)  

- Module Declaraction  
```verilog
module top_module(
	input a,b,c;
	output w,x,y,z
);
```

- Solution
```verilog
module top_module( 
    input a,b,c,
    output w,x,y,z );
    assign w=a;
    
assign x=b;
    
assign y=b;
    
assign z=c;
endmodule
```

#### - 反转器 (Inveter)  

&emsp;&emsp;创建实现非门的模块.  

&emsp;&emsp;这个电路和电线相似,但有点不同.当把电线从进线连接到出线时,我们要实现一个反相器(非门)，而不是一根普通的线.  

&emsp;&emsp;使用assign语句.assign语句将连续地将in取反并输出.  

![notgate](./picture/notgate.png)

- Module
```verilog
module top_module( input in, output out );
```

- Solution
```verilog
module top_module( input in, output out );
	assign out = !in;
endmodule
```

#### - 与门 (AND gate)  

&emsp;&emsp;创建实现和门的模块.  

&emsp;&emsp;这个电路现在有三条线(A、B和OUT).导线A和B已经具有由输入端口驱动的值.但目前的布线并不是由任何东西驱动的.写一个赋值语句,用信号A和B的和来驱动.  

&emsp;&emsp;输入线由模块外部的东西驱动.assign语句将把一个逻辑级别驱动信号连接到一条线上.正如您可能期望的那样,一条线不能有多个驱动信号(如果有的话,它的逻辑级别是什么?),并且没有驱动信号的导线将具有未定义的值(在合成硬件时通常被视为0,但有时候会出现奇怪的错误).  

![andgate](./picture/andgate.png)  

- Module Declaraction
```verilog
module top_module( 
    input a, 
    input b, 
    output out );
```

- Solution
```verilog
module top_module( 
    input a, 
    input b, 
    output out );
assign out = a&b;
endmodule
```

#### - 或非门 (NOR gate)  

&emsp;&emsp;创建实现或非门的模块.或非门是一个输出反转的或门.

&emsp;&emsp;assign语句用一个值来驱动(drive)一条线(或者更正式地称为"net").这个值可以是任意复杂的函数,只要它是一个组合逻辑(即,无内存(memory-less),无隐藏状态).  

![norgate](./picture/norgate.png)  

- Module Declaraction 
```verilog
module top_module( 
    input a, 
    input b, 
    output out );
```

- Solution
```verilog
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = !(a|b);
endmodule
```

#### - 异或非门 (XNOR gate)  
&emsp;&emsp;实现异或非门模块.

![xnor](./picture/xnorgate.png)

- Module Declaraction 
```verilog
module top_module( 
    input a, 
    input b, 
    output out );
```

- Solution
```verilog
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = !(a^b);
endmodule
```


#### - 声明wires  

&emsp;&emsp;到目前为止,电路都十分简单.随着电路变得越来越复杂,您将需要wire将内部组件连接在一起.当您需要使用导线时,您应该在模块体中在首次使用之前的某个地方声明它.(将来,您将遇到更多类型的信号和变量,它们也以相同的方式声明,但现在,我们将从Wire类型的信号开始).

![wiredec](./picture/wire_dec.png)  

```verilog
module top_module (
    input in,              // Declare an input wire named "in"
    output out             // Declare an output wire named "out"
);

    wire not_in;           // Declare a wire named "not_in"

    assign out = ~not_in;  // Assign a value to out (create a NOT gate).
    assign not_in = ~in;   // Assign a value to not_in (create another NOT gate).

endmodule   // End of module "top_module"
```
&emsp;&emsp;实现以下电路.创建两个wire(命名任意)以将and/or gate连接在一起.请注意,Not gate 是输出,因此您不必在这里声明第三条线.wire可有多个输出,但只能有一个输入驱动.  

&emsp;&emsp;如果您遵循图中的电路结构,那么应该以四个赋值语句结束,因为有四个信号需要赋值.  

![wire_dec1](./picture/wire_dec1.png)  


- Module Declaraction 
```verilog
`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
```

- Solution
```verilog
`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
wire inside1,inside2;
    
assign inside1 = a&b;
    
assign inside2 = c&d; 
    
assign out = inside1|inside2;
    
    assign out_n = !(out);
endmodule
```


#### - 7458模块

&emsp;&emsp;实现如下电路:  

![7458](./picture/7458.png)  

- Module Declaraction 
```verilog
module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
```

- Solution
```verilog
module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
wire inside1,inside2,inside3,inside4;
    
assign inside1 = p1a&p1b&p1c;
    
assign inside2 = p1d&p1e&p1f;
    
assign inside3 = p2a&p2b;
    
assign inside4 = p2c&p2d;
    
assign p1y = inside1|inside2;
    
assign p2y = inside3|inside4;

endmodule
```

---

### 容器(Vectors)  

#### - 容器介绍

&emsp;&emsp;vector被用来对相关的信号进行分组,以便于操作.例如,`Wire[7:0]w`;声明一个名为w 的 8 位数组,在功能上相当于具有8条独立的线.  

&emsp;&emsp;请注意，vector的声明将维度(dimensions 即数组长度)放在容器名称之前,这与C语法相比不常见.  

> 至于为什么会是如下声明,主要是采用了小端序.

```verilog
Wire[99:0]my_vector；//声明一个长度为100容器
assign out=my_vector[10]；//从数组中选择一位
```

&emsp;&emsp;构建一个具有一个3位vector输入的电路,并将其拆分为三个单独的1位输出.  

![vector0](./picture/vector0.png)  

- Module Declaraction 
```verilog
module top_module ( 
    input wire [2:0] vec,
    output wire [2:0] outv,
    output wire o2,
    output wire o1,
    output wire o0  ); 
```

- Solution
```verilog
module top_module ( 
    input wire [2:0] vec,
    output wire [2:0] outv,
    output wire o2,
    output wire o1,
    output wire o0  ); // Module body starts after module declaration
    assign o0 = vec[0];
    
    assign o1 = vec[1];
    
    assign o2 = vec[2];
    
assign outv = vec;
endmodule
```

#### - 容器细节



- Module Declaraction 
```verilog
`default_nettype none     // Disable implicit nets. Reduces some types of bugs.
module top_module( 
    input wire [15:0] in,
    output wire [7:0] out_hi,
    output wire [7:0] out_lo );
```

- Solution
```verilog
`default_nettype none     // Disable implicit nets. Reduces some types of bugs.
module top_module( 
    input wire [15:0] in,
    output wire [7:0] out_hi,
    output wire [7:0] out_lo );
    assign out_lo = in[7:0];
    
    assign out_hi = in[15:8];
endmodule
```

#### - 容器的片选(Vector part select)  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 位级操作(Bitwise operators)  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 4位Vecotr  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - Vector连接操作符(Vector concatenation operator)  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 反转Vector  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 拷贝操作符(Replication operator)  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 拷贝练习  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

---

### 模块与层级(Modules: Hierarchy)  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 模块  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 按位置连接端口(Connecting ports by position)  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 按名称连接端口(Connecting ports by name)  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 三个模块  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 模块与容器  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 加法器1  


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 加法器2


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 进位选择加法器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 加-减法器(Adder-subtractor)


- Module Declaraction 
```verilog

```

- Solution
```verilog

```

---

### 过程(Procedures)  

#### - Always块 -- 组合逻辑 (Always blocks -- Combinational)  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - Always块 -- 时序逻辑 (Always blocks -- Clocked)  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - If语句  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - If语句引发的锁存(latches)  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - Case语句  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 简单编码器1  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 简单编码器2  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 避免锁存

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

---

### 更多语法特点  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 三目算符 

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 优化运算1  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 优化运算2  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 循环 -- 组合逻辑:实现Vector反转  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 循环 -- 组合逻辑:实现255位计数器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 循环:实现100位加法器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 循环:实现100位BCD加法器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

---

## 电路 (Circuits)

### 组合逻辑 (Combinational Login)  

#### **基础门电路**   

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - Wire类型  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 接地 -- GND

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 或非门 (NOR)  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 其他的门  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 两个门  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 更多的逻辑门  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 7420模块  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 真值表  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 小练习 -- Two-bit equality  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 简单电路A  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 简单电路B  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 组合电路AB  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 铃声与震动模式  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 恒温器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 3位计数器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 门与容器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 更长的数组  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

---

#### **多路选择器**(Multiplexers)  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 2选1多路选择器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```
#### - 2选1总线选择器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 9选1多路选择器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 256选1多路选择器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 256选1 4位选则器  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

---

#### **卡诺图**  

#### - 3变量  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 4变量 -- 练习一  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 4变量 -- 练习二  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 4变量 -- 练习三  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 最小SOP与POS  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 卡诺图1  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 卡诺图2  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

#### - 多路选择器实现 K-map  

- Module Declaraction 
```verilog

```

- Solution
```verilog

```

---

### 时序逻辑 (Sequential Login)  

#### **锁存器与触发器**  

#### - D-触发器(D flip-flops)  

&emsp;&emsp;D-触发器可以存储一个bit数据并根据时钟信号周期的更新数据，一般是由正边沿触发。
&emsp;&emsp;D-触发器由逻辑合成器(Logic synthesizer)在使用"Always block"时创建(参见AlwaysBlock2)。D-触发器是"组合逻辑块之后连接触发器"的最简单形式，其中组合逻辑部分只是一个wire类型变量。

![dff](./picture/Dff.png)  

&emsp;&emsp;创建一个D-触发器。

- **Module Declaration**  

```verilog
module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
```

- **Solution**
```verilog
module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q );//

    // Use a clocked always block   使用Always block
    //   copy d to q at every positive edge of clk  在时钟信号上升沿时将q复制给d  
    //   Clocked always blocks should use non-blocking assignments  
    /*在Always block内永远都不要使用赋值(Assignment),即assign关键字*/
    always @(posedge clk) begin
        q = d;
    end

endmodule
```

#### - D触发器组合  

&emsp;&emsp;创建8个D触发器，所有的D触发器均由时钟上升沿触发。  

- **Module Declaration**
```verilog
module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk) begin
        q = d;
    end
endmodule
```

#### - 可复位(Reset)的DFF  
&emsp;&emsp;使用主动高位同步复位信号(Reset)创建8个D-触发器。所有的触发器均由时钟上升沿信号触发.  

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
```

- **Solution**
```verilog
module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk) begin
        q <= d & {8{~reset}};
    end
endmodule
```

#### - 可复位为特殊值的D-触发器  
&emsp;&emsp;使用主动高位同步复位信号(Reset)创建8个D-触发器。触发器必须重置为0x34而不是零。所有DFF都应该由CLK的下降沿触发。

- **Module Declaration**
```verilog
module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
```

- **Solution**
```verilog
module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always @(negedge clk) begin
        if(reset) begin
            q <= {8{6'h34}};
        end
        else begin
            q <= d;
        end
    end
endmodule
```

#### - 可异步复位的触发器(Asynchronous Reset)  

&emsp;&emsp;使用主动高位异步复位信号创建8个D-触发器。所有DFF都应该由时钟上升沿触发。 

- **Module Declaration**
```verilog
module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
```

- **Solution**
```verilog
module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk or posedge areset) begin
        if(areset == 1) begin
            q <= 0;
        end
        else begin
            q <= d;
        end
    end
endmodule
```

#### - 有开关的触发器  

&emsp;&emsp;创建16个D-触发器。有时我们希望只修改触发器组的部分值。输入的***开关字节***控制16个寄存器的每个字节是否应在该循环中写入。`byteena[1]`控制上字节`d[15:8]`，而`byteena[0]`控制下字节`d[7:0]`。
&emsp;&emsp;`resetn`是一个同步的、主动的低重置。
&emsp;&emsp;所有DFF都应该由时钟的上升沿触发。

- **Module Delclaration**  
```verilog
module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    always @(posedge clk) begin
        if(resetn == 1) begin
            if(byteena[0] == 1) begin
                q[7:0] <= d[7:0];
            end
            if(byteena[1] == 1) begin
                q[15:8] <= d[15:8];
            end
        end
        else if(resetn == 0) begin
            q <= 0;
        end
    end
endmodule
```

#### - D-锁存器(D Latch)  

&emsp;&emsp;实现如下电路:  
![D Latch](./picture/Exams_m2014q4a.png)  

> 请注意,这是一个锁存器,因此Quartus会报锁存警告  

- **Module Declaration**  
```verilog
module top_module (
    input d, 
    input ena,
    output q);
```

```verilog
module top_module (
    input d, 
    input ena,
    output q);
    wire in,out1,out2;
    always @(*) begin
        out1 = ~(out2 | (~d)&ena);
        out2 = ~(out1 | d&ena);
        q = out1;
    end
endmodule
```

#### - DFF练习1  

&emsp;&emsp;请实现如下电路:  
![DFF1](./picture/Exams_m2014q4b.png)  

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);
    wire out1,out2;
    always @(posedge clk or posedge ar) begin
        if(ar == 1) begin
            q <= 0;
        end
        else if(ar == 0) begin
            q <= d;
        end
    end
endmodule
```

#### - DFF2  

&emsp;&emsp;实现如下电路:  
![DFF2](./picture/Exams_m2014q4c.png)  

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);
    always @(posedge clk) begin
        if(r) begin
            q <= 0;
        end
        else begin
            q = d;
        end
    end
endmodule
```

#### - DFF和gate  

&emsp;&emsp;实现如下电路:  
![DFF and gage](./picture/Exams_m2014q4d.png)  

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input in, 
    output out);
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input in, 
    output out);
    wire out1,out2;
    always @(posedge clk) begin
        out1 = out2 ^ in;
        out2 = out1;
        out = out2;
    end
endmodule
```

#### - 多路选择器与触发器1  

&emsp;&emsp;考虑如下时序电路:  
![MandD](./picture/Mt2015_muxdff.png)  

&emsp;&emsp;假设您想为如下电路实现层级化(Hierarchical)的代码,使用3个子级模块的实例,子级模块由触发器与多路选择器构成.您的顶级模块应当由含子级模块实现.

> 注: 这是一种封装的思想  

- **Module Declaration**  
```verilog
module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
```

- **Solution**  
```verilog
module top_module (
        input clk,
        input L,
        input r_in,
        input q_in,
        output reg Q);

    wire out1;
    always @(*) begin
        case (L)
            1'b0: begin
                out1 <= q_in;
            end
            1'b1: begin
                out1 <= r_in;
            end
        endcase
    end
    always @(posedge clk) begin
        Q <= out1;
    end
endmodule
```

#### - 多路选择器与触发器2  

&emsp;&emsp;考虑如下n位变换寄存器电路:  
![mandD2](./picture/Exams_2014q4.png)

&emsp;&emsp;为这个电路实现一个一阶模块,并命名为`top_module`,可供此电路调用.你的模块应包括触发器与多路选择器.  

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire out1,out2;
    always @(posedge clk) begin
        case (E)
            1'b0: begin
                out1 = Q;
            end
            1'b1: begin
                out1 = w;
            end
        endcase
        case (L)
            1'b0: begin
                Q = out1;
            end
            1'b1: begin
                Q = R;
            end
        endcase
    end
endmodule
```

#### - DFFs和gates  

&emsp;&emsp;给定如下有限状态机电路,假设D-触发器在状态机开始前被初始化为0.  

&emsp;&emsp;构建如下电路.  
![dag](./picture/Ece241_2014_q4.png)  

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input x,
    output z
); 
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input x,
    output z
); 
    reg out1, out2, out3;
    initial z = 1;
    always @(posedge clk) begin
        out1 = x ^ out1;
        out2 = x & ~out2;
        out3 = x | ~out3;
        z = ~(out1 | out2 | out3);
    end
endmodule
```

#### - 根据真值表实现电路  

&emsp;&emsp;JK触发器有如下真值表.通过一个D-触发器和几个gate实现一个JK触发器.  

> 注意:Qold是D-触发器在上升沿之前的输出.

|J|K|Q|
|:--:|:---:|:--:|
|0|0|Qold|
|0|1|0|
|1|0|1|
|1|1|~Qold|

- **Module Declaration**
```verilog
module top_module (
    input clk,
    input j,
    input k,
    output Q); 
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    wire old = Q;
    always @(posedge clk) begin
        if(j^k) begin
            Q = j;
        end
        else begin
            Q = j?~old:old;
        end
    end
endmodule
```

#### - 边缘检测(Detect an edge)  

&emsp;&emsp;对于每一个8位容器,在一个时钟周期内,当输入信号从0,变为下个周期的1时进行检测.(类似于上升沿检测).当对应位从0变为1时应当设置输出位.

&emsp;&emsp;以下为波形样例,为了清楚起见,`in[1]`与`pedge[1]`被分别显示.  
![example](./picture/example.png)  

- **Module Declaration**
```verilog
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
```

- **Solution**  
```verilog
module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
	
	reg [7:0] d_last;	
			
	always @(posedge clk) begin
		d_last <= in;			// Remember the state of the previous cycle
		pedge <= in & ~d_last;	// A positive edge occurred if input was 0 and is now 1.
	end
	
endmodule
```

#### - 边缘检测2  
&emsp;&emsp;对于每一个8位容器,在一个时钟周期内,当输入信号从0,变为下个周期的1时进行检测.(上升沿与下降沿均触发).当对应位从0变为1时应当设置输出位.  

&emsp;&emsp;以下为波形样例,为了清楚起见,`in[1]`与`anyedge[1]`被分别显示.  
![edge](./picture/edge.png)

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
   reg [7:0] temp;
   always @(posedge clk) begin
       temp <= in;
       anyedge <= temp ^ in;
   end
endmodule
```

#### - 边缘捕获寄存器(Edge capture register)  

&emsp;&emsp;对于32位Vector中的每一位，当输入信号在一个时钟周期内从1变为下一个时钟周期的0时进行捕获。"捕获"表示输出将保持1，直到寄存器复位（同步复位 -- Synchronous Reset）。

&emsp;&emsp;每个输出位的行为类似于SR触发器：在发生1到0的转换之后，输出位应该被设置为1。当复位为高电平时，输出位应在上升沿复位(至0)。如果上述两个事件同时发生，则重置(Reset)具有优先权。在下面示例波形的最后4个周期中，"Reset"事件比"Set"事件早一个周期，因此这里没有冲突。
![capture](./picture/edgecapture.png)

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
```

- **Solution**
```verilog
module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] old,result,temp;
    initial temp = 0;
    always @(posedge clk) begin
        if(reset) begin
            old = in;
            result = 0;
            out = 0;
        end
        else begin
            temp = (in ^ old) & old;
            result = result | temp;
            out = result;
            old = in;
        end
    end 
endmodule
```

#### - 双边沿出发(Dualedge)

&emsp;&emsp;你现在已经比较熟悉上升沿或者下降沿出发的触发器了.而双边触发器在时钟上升沿与下降沿都会触发.但是FPGA并没有双边沿触发器,并且`always @(posedge clk or negedge clk)`是非法的.  

&emsp;&emsp;构建一个电路来实现类似于双边触发器的功能:  
![dualedge](./picture/dualedge.png)

> 注意:并不需要完全等效:在这里触发器的输出没什么毛病,但是在更大的电路中模拟这种行为可能会有故障,我们在这里忽略这个细节.  

- Hint:  
  - 你不能在FPGA上创建双边沿触发器,但是组合上升沿与下降沿触发器.  
  - 这个问题是一个中等难度的电路设计问题，但只需要基本的verilog语言特性.(这是一个电路设计问题，而不是编码问题.)在试图对电路进行编码之前，先用手画出电路草图可能会有所帮助。

- **Module Declaraction**  
```verilog
module top_module (
    input clk,
    input d,
    output q
);
```

- **Solution**
```verilog
module top_module (
    input clk,
    input d,
    output q
);
    reg [1:0] status;
    always @(posedge clk) begin
        status[0] = d;
    end
    always @(negedge clk) begin
        status[1] = d;
    end
    assign q = clk ? status[0] : status[1];
endmodule
```


#### **计数器(Counters)**  

#### - **四位二进制计数器**  

&emsp;&emsp;构建一个0-15的四位二进制计数器,句点为16.重置输入是同步的,应将计数器重置为0. ![counter5](./picture/counter.png)

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
    always @(posedge clk) begin
        if(!reset) begin
            if(q == 4'hf) begin
                q = 0;
            end
            else begin
                q = q + 1;
            end
        end
        else begin
            q = 0;
        end
    end
endmodule
```

#### - 十进制计数器  

&emsp;&emsp;建立一个从0到9的十进制计数器,句点为10,重置输入是同步的,应该将计数器重置为0.  
![counter10](./picture/counter10.png)  

- **Module Declaration**  
```verilog
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
    
    always @(posedge clk) begin
        if(reset) begin
            q <= 0;
        end
        else begin
            if(q = 4'd10) begin
                q = 0;
            end
            else begin
                q = q + 1;
            end
        end
    end
endmodule
```

#### - 十进制计数器1  

&emsp;&emsp;建立一个从0到9的十进制计数器,句点为10,重置输入是同步的,应该将计数器重置为1.  
![counter10_1](./picture/counter10_1.png)  

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input reset,
    output [3:0] q);
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input reset,
    output [3:0] q);
    always @(posedge clk) begin
        if(reset) begin
            q <= 1;
        end
        else begin
            if(q == 4'ha) begin
                q = 1;
            end
            else begin
                q = q + 1;
            end
        end
    end
endmodule
```

#### - **慢序十进制计数器**  

&emsp;&emsp;构建一个0到9的十进制计数器,句点为10.reset信号是同步的,将计数器置零.我们希望能够暂停计数器,而不是在每个时钟周期内增加,因此slowena控制计数器的增加.  
![countslow](./picture/counterslow.png)

- **Module Declaration**  
```verilog
module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
```

- **Solution**  
``` verilog
module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    always @(posedge clk) begin
        if(reset) begin
            q <= 0;
        end
        else begin
            if(slowena) begin
                if(q == 4'd9) begin 
                    q = 0;
                end
                else begin
                    q = q + 1;
                end
            end
            else begin
                q = q + 0;
            end
        end
    end
endmodule
```

#### - **Counter1-12**  

设计一个具有以下输入输出的Counter:  
 - 同步高位`Reset`信号将寄存器重置为0  
- 当`enable`为高位时Counter进行工作  
- 时钟信号上升沿触发  
- `Q[3:0]` 为counter的输出  
- `c_enable, c_load, c_d[3:0]`三个控制信号发送到所提供的4-bit Counter模块,以便检验正确操作.  
你可以使用如下组件:  

&emsp;&emsp;如下4位计数器,`enable`与`load`同步并行输入(load的优先级高于enable).这个count4模块提供给你,在你的模块中实例化他.  
```verilog
module count4(
	input clk,
	input enable,
	input load,
	input [3:0] d,
	output reg [3:0] Q
);
```


- **Module Declaration**
```verilog
module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); 
```

- **Solution**  
```verilog
module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
    wire [3:0] Q_tmp;
    assign c_enable = enable;
    assign c_d = c_load ? 1 : 0;
    always @(posedge clk) begin
        if(reset) begin
            Q <= 1;
            Q_tmp <= 1;
        end
        else begin
            if(enable) begin
                if(Q == 12) begin
                    Q <= 1;
                    Q_tmp <= 1;
                end
                else begin
                    Q <= Q + 1;
                    Q_tmp <= Q_tmp + 1;
                end
            end
        end
    end
    
    always @(*) begin
        if(reset || (Q == 12 && c_enable)) begin
            c_load <= 1;
        end
        else begin
            c_load <= 0;
        end
    end

    count4 the_counter (clk, c_enable, c_load, c_d, Q_tmp);

endmodule
```

#### - 4位左右移寄存器(4-bit shift regisger)  



#### - 4位左右旋转器(Left/right rotator)  



#### - 算数左右移  

&emsp;&emsp;构建一个64为算数寄存器,具有同步load信号.这个shifter根据`amount`信号选择,可左右移1位或8位.  
&emsp;&emsp;在算数右移时,若符号位(q[63])为1则需要复制位,而并非简单的逻辑右移.另一种考虑方式,假定被移位的数字有符号并保留符号,这样算术右移将有符号数字除以2的幂.  
&emsp;&emsp;算数左移与逻辑左移没有区别.  

- `load`: 寄存器载入数据(优先级最高)  
- `ena`: 决定是否发生位移  
- `amount`: 决定位移的方向  
  - 2'b00: 左移一位  
  - 2'b01: 左移8位  
  - 2'b10: 右移一位  
  - 2'b11: 右移8位  
- `q`: shifter的内容

- **Module Declaration**  
```verilog
module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
```

- **Solution**  
```verilog
module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end
        else begin
            if(ena) begin
                case (amount)
                    2'b00: begin 
                        q <= q << 1;
                    end
                    2'b01: begin
                        q <= q << 8;
                    end
                    2'b10: begin
                        q <= q >> 1;
                        if(q[63] == 1) begin
                            q[63] <= 1;
                        end
                    end
                    2'b11: begin
                        q <= q >> 8;
                        if(q[63] == 1) begin
                            q[63:56] <= {8{1'b1}};
                        end
                    end
                endcase
            end
        end
    end
endmodule
```







---

### 练习 -- 更大型电路  

---
































































