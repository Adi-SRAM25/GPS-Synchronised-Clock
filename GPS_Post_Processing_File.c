#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "pmodGPS.h"

/**** Macro Definitions ****/

#ifdef XPAR_CPU_CORTEXA9_0_CPU_CLK_FREQ_HZ
#define PERIPHERAL_CLK 100000000 // FCLK0 frequency is not in xparameters.h for some reason
#else
#define PERIPHERAL_CLK XPAR_CPU_M_AXI_DP_FREQ_HZ
#endif

#ifdef XPAR_XINTC_NUM_INSTANCES
#include "xintc.h"
#define INTC         XIntc
#define INTC_HANDLER XIntc_InterruptHandler
#else
#ifdef XPAR_SCUGIC_0_DEVICE_ID
#include "xscugic.h"
#define INTC         XScuGic
#define INTC_HANDLER XScuGic_InterruptHandler
#endif
#endif


/**** Function Prototypes ****/

void DemoInitialize();

void DemoRun();

int SetupInterruptSystem(PmodGPS *InstancePtr, u32 interruptDeviceID,
      u32 interruptID);

void EnableCaches();

void DisableCaches();


/**** Global Variables ****/

PmodGPS GPS;
INTC intc;


/**************/

int SetupInterruptSystem(PmodGPS *InstancePtr, u32 interruptDeviceID,
      u32 interruptID) {
   int Result;
   u16 Options;

#ifdef XPAR_XINTC_NUM_INSTANCES
   INTC *IntcInstancePtr = &intc;
   /*
    * Initialize the interrupt controller driver so that it's ready to use.
    * specify the device ID that was generated in xparameters.h
    */
   Result = XIntc_Initialize(IntcInstancePtr, interruptDeviceID);
   if (Result != XST_SUCCESS) {
      return Result;
   }

   /* Hook up interrupt service routine */
   XIntc_Connect(IntcInstancePtr, interruptID,
         (Xil_ExceptionHandler) XUartNs550_InterruptHandler,
         &InstancePtr->GPSUart);

   /* Enable the interrupt vector at the interrupt controller */

   XIntc_Enable(IntcInstancePtr, interruptID);

   /*
    * Start the interrupt controller such that interrupts are recognized
    * and handled by the processor
    */
   Result = XIntc_Start(IntcInstancePtr, XIN_REAL_MODE);
   if (Result != XST_SUCCESS) {
      return Result;
   }
   XUartNs550_SetHandler(&InstancePtr->GPSUart, (void*)GPS_intHandler,
         InstancePtr);

   /*
    * Initialize the exception table and register the interrupt
    * controller handler with the exception table
    */
   Xil_ExceptionInit();

   Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
         (Xil_ExceptionHandler)INTC_HANDLER, IntcInstancePtr);

   /* Enable non-critical exceptions */
   Xil_ExceptionEnable();
   Options = XUN_OPTION_DATA_INTR |
   XUN_OPTION_FIFOS_ENABLE;
   XUartNs550_SetOptions(&InstancePtr->GPSUart, Options);

#endif
#ifdef XPAR_SCUGIC_0_DEVICE_ID
   INTC *IntcInstancePtr = &intc;
   XScuGic_Config *IntcConfig;

   /*
    * Initialize the interrupt controller driver so that it is ready to
    * use.
    */
   IntcConfig = XScuGic_LookupConfig(interruptDeviceID);
   if (NULL == IntcConfig) {
      return XST_FAILURE;
   }

   Result = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
         IntcConfig->CpuBaseAddress);
   if (Result != XST_SUCCESS) {
      return XST_FAILURE;
   }

   XScuGic_SetPriorityTriggerType(IntcInstancePtr, interruptID, 0xA0, 0x3);

   /*
    * Connect the interrupt handler that will be called when an
    * interrupt occurs for the device.
    */
   Result = XScuGic_Connect(IntcInstancePtr, interruptID,
         (Xil_ExceptionHandler) XUartNs550_InterruptHandler,
         &InstancePtr->GPSUart);
   if (Result != XST_SUCCESS) {
      return Result;
   }

   /*
    * Enable the interrupt for the GPIO device.
    */
   XScuGic_Enable(IntcInstancePtr, interruptID);

   XUartNs550_SetHandler(&InstancePtr->GPSUart, (void*) GPS_intHandler,
         InstancePtr);

   /*
    * Initialize the exception table and register the interrupt
    * controller handler with the exception table
    */
   Xil_ExceptionInit();

   Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
         (Xil_ExceptionHandler) INTC_HANDLER, IntcInstancePtr);

   /* Enable non-critical exceptions */
   Xil_ExceptionEnable()
   ;

   Options = XUN_OPTION_DATA_INTR | XUN_OPTION_FIFOS_ENABLE;
   XUartNs550_SetOptions(&InstancePtr->GPSUart, Options);
#endif

   return XST_SUCCESS;
}
/**************/
void EnableCaches() {
#ifdef _MICROBLAZE_
#ifdef XPAR_MICROBLAZE_USE_DCACHE
   Xil_DCacheEnable();
#endif
#ifdef XPAR_MICROBLAZE_USE_ICACHE
   Xil_ICacheEnable();
#endif
#endif
}
/******************/
void DisableCaches() {
#ifdef _MICROBLAZE_
#ifdef XPAR_MICROBLAZE_USE_DCACHE
   Xil_DCacheDisable();
#endif
#ifdef XPAR_MICROBLAZE_USE_ICACHE
   Xil_ICacheDisable();
#endif
#endif
}


/*****************/
void DemoInitialize() {
   GPS_begin(&GPS, XPAR_PMODGPS_0_AXI_LITE_GPIO_BASEADDR,
         XPAR_PMODGPS_0_AXI_LITE_UART_BASEADDR, PERIPHERAL_CLK);
   EnableCaches();
#ifdef _MICROBLAZE_
   // Set up interrupts for a MicroBlaze system
   SetupInterruptSystem(&GPS, XPAR_INTC_0_DEVICE_ID,
         XPAR_INTC_0_PMODGPS_0_VEC_ID);
#else
   // Set up interrupts for a Zynq system
   SetupInterruptSystem(&GPS, XPAR_PS7_SCUGIC_0_DEVICE_ID,
         XPAR_FABRIC_PMODGPS_0_GPS_UART_INTERRUPT_INTR);
#endif

   GPS_setUpdateRate(&GPS, 1000);
}


void DemoRun() {

      if (GPS.ping) {
         GPS_formatSentence(&GPS);
         if (GPS_isFixed(&GPS)) {
            string a = GPS_getTime(&GPS);
            int Hour = (int (a[0:1]) + 5)%24;
            int Minutes = (int (a[2:3]) + 30)%60;
            int Seconds = int (a[4:5]);
               
        	printf("Time Stamp: %d", Hour);
            printf(":%d", Minutes);  
            printf(":%d", Second);  
            //xil_printf("Latitude: %s\n\r", GPS_getLatitude(&GPS));
            //xil_printf("Longitude: %s\n\r", GPS_getLongitude(&GPS));
            //xil_printf("Altitude: %s\n\r", GPS_getAltitudeString(&GPS));
            //xil_printf("Number of Satellites: %d\n\n\r", GPS_getNumSats(&GPS));
         }
        
      }

   DisableCaches();
}


int main()
{
    init_platform();
    XGpio input;
    DemoInitialize();


    XGpio_Initialize(&input, XPAR_AXI_GPIO_0_DEVICE_ID);
    // Data direction register : input-1 , output - 0

    XGpio_SetDataDirection(&input, 1, 0xfffffff);
    long long int a;

    while(1)
    {

    	a=XGpio_DiscreteRead(&input, 1);
        xil_printf("Sampled Data: ");
        xil_printf("0x%x", rand()%65536);
        DemoRun();
        xil_printf("(Sub-Second):%d\r\n", a);

    }
    cleanup_platform();
    return 0;
}
