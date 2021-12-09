The WDMSKEL driver is a skeleton of a WDM driver illustrating how you
might convert an existing kernel-mode driver for a legacy device to WDM.
This sample accompanies the white paper "Converting a Kernel Mode Driver
to WDM" by Walter Oney, available at http://www.oneysoft.com. Be sure
to read that paper for important information about restrictions and
assumptions built into this sample.

You can use the regular DDK "BUILD" utility with this project if you
wish. Or, you can open WDMSKEL.DSP in Microsoft Visual C++ version 6.0.
If you're using VC6, define the following environment variables:

DDKPATH = Base directory for the NT 5 DDK. (E.g., c:\nt5ddk)
SIWPATH = Installation directory for Soft-Ice/W if you you have it.

The VC6 build has a Post-Build step that copies the finished driver
to the DRIVERS directory and runs NMSYM to translate the symbols for
Soft-Ice. Modify or eliminate this step to meet your own needs.