program main
  implicit none
  character (len = 4) :: command
  integer :: v
  integer :: reason
  integer :: cycle
  integer :: sum
  integer :: x
  character (:), allocatable :: crt

  x = 1
  cycle = 0
  sum = 0
  
  reason = 0
  do while (reason == 0)
    read (*, '(axi10)', iostat=reason) command, v
    call check_cycle(cycle, sum, x, crt)
    if (command == 'addx') then
      call check_cycle(cycle, sum, x, crt)
      x = x + v
    end if
  end do
  print *, "part 1:", sum
  contains

  subroutine check_cycle(cycle, sum, x, crt)
    implicit none
    integer, intent(in) :: x
    integer, intent(inout) :: cycle
    integer, intent(inout) :: sum
    character (:), allocatable, intent(inout) :: crt

    if (mod(cycle, 40) >= x - 1 .and. mod(cycle, 40) <= x + 1) then
      crt = crt//'#'
    else
      crt = crt//'.'
    end if
    if (mod (cycle + 1, 40) == 0) then
      print *, crt
      crt = ""
    end if
    cycle = cycle +1
    if (mod (cycle - 20, 40) == 0) then
      sum = sum + cycle * x
    end if
  end subroutine check_cycle
end program
