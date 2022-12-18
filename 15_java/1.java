import java.util.*;

public class Main {
	public static void main(String [] args) {
		int part1Y = 2000000;
		HashSet<Integer> noBeacon = new HashSet();
		HashSet<Integer> beacon = new HashSet();
		Scanner in = new Scanner(System.in);
		while (in.hasNext()) {
			String line = in.nextLine();
			Scanner l = new Scanner(line
					.replace(" ", "")
					.replace("=", " ")
					.replace(",", " ")
					.replace(":", " "));
			l.next();
			int sx = l.nextInt();
			l.next();
			int sy = l.nextInt();
			l.next();
			int bx = l.nextInt();
			l.next();
			int by = l.nextInt();
			
			if (by == part1Y) {
				beacon.add(bx);
			}

			int distance = calcDistance(sx, sy, bx, by);
			int yDiff = Math.abs(part1Y - sy);
			int xOffset = distance - yDiff;
			if (xOffset >= 0) {
				for (int i = sx - xOffset; i <= sx + xOffset; i ++) {
					noBeacon.add(i);
				}
			}

		}
		System.out.print("Part 1: ");
		System.out.println(noBeacon.size() - beacon.size());
	}
	public static int calcDistance(int sx, int sy, int bx, int by) {
		return Math.abs(sx - bx) + Math.abs(sy - by);
	}
}
