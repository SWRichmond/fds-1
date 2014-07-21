@echo off
:: This script deletes previous Intel MPI firewall exceptions
:: and creates 2 new rules opening ports equivalent to PORT_VAL.
:: It then sets env variable MPICH_PORT_RANGE to match PORT_VAL.

set PORT_VAL=8670-8690
netsh advfirewall firewall delete rule name="Intel MPI Port for FDS" > Nul
netsh advfirewall firewall add rule dir=in action=allow name="Intel MPI Port for FDS" profile=domain protocol=tcp localport=%PORT_VAL% > Nul
netsh advfirewall firewall add rule dir=in action=allow name="Intel MPI Port for FDS" profile=domain protocol=udp localport=%PORT_VAL% > Nul

setx MPIEXEC_PORT_RANGE 8670:8690 > Nul
setx MPICH_PORT_RANGE 8670:8690 > Nul

smpd -install > Nul
