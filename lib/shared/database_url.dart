abstract class Database {
  static const String hoster = "http://localhost:8080/";
  //this section for colleges
  static const collegeRead =
      hoster + "course_SCHEDUALING/API/Colleges/read.php";
  static const collegeDelete =
      hoster + "/COURSE_SCHEDUALING/API/Colleges/delete.php";
  static const addColege =
      hoster + "/COURSE_SCHEDUALING/API/Colleges/create.php";
  static const ColegeEdit =
      hoster + "/COURSE_SCHEDUALING/API/Colleges/update.php";
  //colleges

  //this section for Permessions
  static const permessionRead =
      hoster + "COURSE_SCHEDUALING/API/Permessions/read.php";
  static const grantPermession =
      hoster + "course_SCHEDUALING/API/EmployeePermessions/create.php";
  static const revokePermession =
      hoster + "course_SCHEDUALING/API/EmployeePermessions/delete.php";
  //Permessions

  //this section for Ranks
  static const rankRead = hoster + "couRSE_SCHEDUALING/API/Ranks/read.php";
  static const deleteRank = hoster + "couRSE_SCHEDUALING/API/Ranks/delete.php";
  static const updateRank = hoster + "couRSE_SCHEDUALING/API/Ranks/update.php";
  static const createRank = hoster + "couRSE_SCHEDUALING/API/Ranks/create.php";
  //Ranks

  //this section for Jobs
  static const jobRead = hoster + "couRSE_SCHEDUALING/API/Jobs/read.php";
  static const deleteJob = hoster + "couRSE_SCHEDUALING/API/Jobs/delete.php";
  static const updateJob = hoster + "couRSE_SCHEDUALING/API/Jobs/update.php";
  static const addJob = hoster + "couRSE_SCHEDUALING/API/Jobs/create.php";
  //end Jobs

  //this section for times
  static const timeRead = hoster + "course_SCHEDUALING/API/Times/read.php";
  static const timeDelete = hoster + "course_SCHEDUALING/API/Times/delete.php";
  static const createTime = hoster + "course_SCHEDUALING/API/Times/create.php";
  static const updateTime = hoster + "course_SCHEDUALING/API/Times/update.php";
  //end times

  //this section for courses
  static const courseRead = hoster + "course_SCHEDUALING/apI/Courses/read.php";
  static const courseDelete =
      hoster + "course_SCHEDUALING/apI/Courses/delete.php";
  static const CourseEdit =
      hoster + "course_SCHEDUALING/apI/Courses/update.php";
  static const CourseAdd = hoster + "course_SCHEDUALING/apI/Courses/create.php";
  //end courses

  //this section for departments
  static const departmentRead =
      hoster + "course_SCHEDUALING/API/Departments/read.php";
  static const departmentAdd =
      hoster + "course_SCHEDUALING/API/Departments/create.php";
  static const departmentDelete =
      hoster + "course_SCHEDUALING/API/Departments/delete.php";
  static const departmentUpdate =
      hoster + "course_SCHEDUALING/API/Departments/update.php";
  //end departments

  //this section for employees
  static const deleteEmployee =
      hoster + "course_SCHEDUALING/API/Employees/delete.php";
  static const updateEmployee =
      hoster + "course_SCHEDUALING/API/Employees/update.php";
  static const createEmployee =
      hoster + "course_SCHEDUALING/API/Employees/create.php";
  static const employeeLoginRead =
      hoster + 'course_SCHEDUALING/API/Employees/readIdPassword.php';
  static const employeeRead =
      hoster + "course_SCHEDUALING/API/Employees/read.php";
  static const jobRankDepartmentRead =
      hoster + "course_SCHEDUALING/API/JobRankDepartment/read.php";
  //end employees

  //this section for taeching matrix
  static const teachingMatrixRead =
      hoster + "course_SCHEDUALING/API/TeachingMatrix/read.php";
  static const teachingMatrixCreate =
      hoster + "course_SCHEDUALING/API/TeachingMatrix/create.php";
  static const teachingMatrixDelete =
      hoster + "course_SCHEDUALING/API/TeachingMatrix/delete.php";
  //end teaching matrix

  //this section for semester
  static const semesterRead =
      hoster + "course_SCHEDUALING/API/semesters/read.php";
  static const semesterUpdate =
      hoster + "course_SCHEDUALING/API/semesters/update.php";
  static const semesterDelete =
      hoster + "course_SCHEDUALING/API/semesters/delete.php";
  static const addSemester =
      hoster + "course_SCHEDUALING/API/semesters/create.php";
  //end semester

  //this section for employee semester
  static const employeeSemesterRead =
      hoster + "course_SCHEDUALING/API/EmployeePrecense/read.php";
  //this for create employee semester
  static const employeeSemesterCreate =
      hoster + "course_SCHEDUALING/API/EmployeeSemesters/create.php";
  //this for create employee semester day
  static const employeeSemesterDayCreate =
      hoster + "course_SCHEDUALING/API/EmployeeSemesterDays/create.php";
  static const employeeSemesterDayDelete =
      hoster + "course_SCHEDUALING/API/EmployeeSemesterDays/delete.php";
  static const employeeSemesterUpdate =
      hoster + "course_SCHEDUALING/API/EmployeeSemesters/update.php";
  //end employee semester

  //this section for classes
  static const classesRead =
      hoster + "course_SCHEDUALING/API/CoursesClasses/read.php";
  static const readCoursesSpecificDepartment =
      hoster + "course_SCHEDUALING/apI/Courses/departmentRead.php";
  static const deptTeachingMatrixRead =
      hoster + "course_SCHEDUALING/API/TeachingMatrix/departmentRead.php";
  static const deptEmployees =
      hoster + "course_SCHEDUALING/API/Employees/readDepartmentEmployee.php";
  static const teacherHour =
      hoster + "course_SCHEDUALING/API/CoursesClasses/readTeacherHour.php";
  static const openCourse =
      hoster + "course_SCHEDUALING/API/OpenCourse/create.php";
  //end classes

  //this section for run GENTIC ALGORITHM
  static const runAlgorithm =
      hoster + "course_SCHEDUALING/API/GenticAlgorithm/GARoot.php";
  //END GENTIC ALGORITHM

//this section for graduate student
  static const graduateStdRead =
      hoster + "course_SCHEDUALING/API/questionnairses/get_by_semester.php";
  static const deleteGraduateCourse = hoster +
      "course_SCHEDUALING/API/questionnairses/delete_graduate_course.php";
  static const graduateCourseRead =
      hoster + "course_SCHEDUALING/API/Courses/get_base_courses.php";
  static const graduateStudentRead =
      hoster + "course_SCHEDUALING/API/students/get_department_student.php";
  static const addGraduateCourse =
      hoster + "course_SCHEDUALING/API/students/add_graduate_course.php";
  //end graduate student
}
