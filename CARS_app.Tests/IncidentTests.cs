using CARS_app.Model;
using CARS_app.Repository;
using NUnit.Framework;

namespace CARS_app.Tests
{
	public class IncidentTests
	{
		IIncidentRepository incidentRepository = new IncidentRepository();

		[Test]
		public void TestToAddIncident()
		{
			Incident incident = new Incident()
			{
				IncidentType = "Homicide",
				IncidentDate = DateTime.Now,
				Location = "Test location",
				Description = "Test description",
				Status = "Open",
				AgencyId = 1
			};
			int addIncidentStatus = incidentRepository.AddIncident(incident);
			Assert.That(addIncidentStatus, Is.GreaterThan(0), "Incident ID should be greater than 0");
		}

		[Test]
		public void TestToUpdateIncident()
		{
			int incidentId = 2;
			string status = "Closed";
			int updateIncidentStatus = incidentRepository.UpdateIncidentStatus(incidentId, status);
			Assert.That(updateIncidentStatus, Is.EqualTo(1));
		}
	}
}
