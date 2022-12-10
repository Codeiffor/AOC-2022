program main
  implicit none
  character (len = 4) :: command
  integer :: v
  integer :: reason
  integer :: cycle
  integer :: sum
  integer :: x

  x = 1
  cycle = 0
  sum = 0
  
  reason = 0
  do while (reason == 0)
    read (*, '(axi10)', iostat=reason) command, v
    call check_cycle(cycle, sum, x)
    if (command == 'addx') then
      call check_cycle(cycle, sum, x)
      x = x + v
    end if
  end do
  print *, sum
  contains

  subroutine check_cycle(cycle, sum, x)
    implicit none
    integer, intent(in) :: x
    integer, intent(inout) :: cycle
    integer, intent(inout) :: sum

    cycle = cycle +1
    if (mod (cycle - 20, 40) == 0 .and. cycle >= 20 .and. cycle <= 220) then
      sum = sum + cycle * x
    end if
  end subroutine check_cycle
end program