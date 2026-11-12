using System.Net;

namespace Sosyolobi.Api.Exceptions;

public class ApiException : Exception
{
    public string Code { get; }
    public HttpStatusCode StatusCode { get; }

    public ApiException(string code, string message, HttpStatusCode statusCode = HttpStatusCode.BadRequest) : base(message)
    {
        Code = code;
        StatusCode = statusCode;
    }
}
